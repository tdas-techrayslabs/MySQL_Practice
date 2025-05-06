<script setup>
import { onMounted, ref, shallowRef } from 'vue'
import { useDate } from 'vuetify'
import { mdiPlus } from '@mdi/js';


const { $axios } = useNuxtApp();

const adapter = useDate()

const students = ref([]);

const errorMessage = ref('');

const DEFAULT_RECORD = { name: '', roll_no: null, className: '', city: '' }

const record = ref(DEFAULT_RECORD)
const dialog = shallowRef(false)
const isEditing = shallowRef(false)

const headers = [
  { title: 'Id', key: 'id', align: 'start' },
  { title: 'Name', key: 'name' },
  { title: 'Roll No', key: 'roll_no' },
  { title: 'Class', key: 'className', align: 'end' },
  { title: 'City', key: 'city', align: 'end' },
  { title: 'Actions', key: 'actions', align: 'end', sortable: false },
]


onMounted(() => {
  reset()
})

function add() {
  isEditing.value = false
  record.value = structuredClone(DEFAULT_RECORD); 
  dialog.value = true
}

function edit(id) {
  isEditing.value = true

  const found = students.value.find(student => student.id === id);

  console.log(found);

  if (!found) return;

  record.value = {
    id: found.id,
    name: found.name,
    roll_no: found.roll_no,
    className: found.className || "",
    city: found.city,
  }

  dialog.value = true
}

async function remove(id) {
  const confirmed = confirm("Are you sure you want to delete this student?")

  if (!confirmed) return

  try {
    await $axios.delete(`/delete/${id}`)

    students.value = students.value.filter(student => student._id !== id)

    await reset();

    alert("Student deleted successfully")
  } catch (error) {
    console.log("Error deleting student: ", error);

    alert('Failed to delete studnet');
  }
  // const index = books.value.findIndex(book => book.id === id)
  // books.value.splice(index, 1)
}

const onUpdateSubmit = async (id, values) => {
  dialog.value = false;

  try {
    const res = await $axios.put(`/update/${id}`, values);
    console.log("Update success: ", res.data);
    await reset(); // refetch students
    alert('Student details updated successfully');
  } catch (error) {
    console.log(error);
    
    if (error.response) {
      errorMessage.value = error.response.data.message;
    } else {
      errorMessage.value = "Something went wrong. Please try again.";
    }
  }
};


async function save() {
  if (isEditing.value) {
    const { id, ...values } = record.value;
    await onUpdateSubmit(id, values);
  } else {
    // Handle new student creation
    await onSubmit(record.value);
  }

  if (!errorMessage.value) {
    record.value = { ...DEFAULT_RECORD };
    dialog.value = false;
  }

}

async function onSubmit(values) {
  dialog.value = false;

  

  try {
    const res = await $axios.post("/create", values);
    console.log("Student created: ", res.data);
    await reset(); // Re-fetch updated students list
    alert('Student created successfully');
  } catch (error) {
    dialog.value = true; 
    console.log(error);
    if (error.response && error.response.status === 409) {
      errorMessage.value = error.response.data.message || "Duplicate roll number not allowed";
    } else {
      errorMessage.value = "Something went wrong. Please try again.";
    }
  }
}



async function reset() {
  dialog.value = false
  record.value = DEFAULT_RECORD
  const res = await $axios.get('/students');

  console.log(res.data);

  students.value = await res.data.data;
}




const nameRules = [
  value => {
    if (value) return true
    return 'You must enter a name'
  },
  value => {
    if (value?.length >= 2 && value?.length <= 50 && (value?.charAt(0) === value?.charAt(0).toUpperCase())) return true

    else if (value?.length < 2 && value?.length > 50) return 'Name must be between 2 to 50 characters long'

    else if (value?.charAt(0) !== value?.charAt(0).toUpperCase()) return 'Name must start with uppercase'
  }
]

const rollNoRules = [
  value => {
    if (value) return true
    return 'You must enter a roll no.'
  },
  value => {
    if (value > 0 && value <= 150) return true

    return 'Name must be positive and between 1 to 150'
  }
]

const classNameRules = [
  value => {
    if (value) return true
    return 'You must enter a class'
  },
  value => {
    if (value?.length >= 2 && (value?.charAt(0) === value?.charAt(0).toUpperCase())) return true

    else if (value?.length < 2) return 'Class must be atleast 2 characters long'

    else if (value?.charAt(0) !== value?.charAt(0).toUpperCase()) return 'Class must start with uppercase'
  }
]

const cityRules = [
  value => {
    if (value) return true
    return 'You must enter a city'
  },
  value => {
    if (value?.length >= 2) return true
    return 'City must be atleast 2 characters long'
  }
]

const search = ref('');



</script>

<template>

  <div class="w-screen h-screen flex justify-center items-center bg-slate-900">
    <div class="w-full max-w-[1200px] mx-auto bg-white rounded-md p-8">

      <!-- <h1 class="text-5xl font-bold mb-8 mt-3 mx-4">Students List</h1> -->

      <v-card-title class="d-flex align-center ps-2">
        <h1 class="text-5xl font-bold mb-8 mt-3 mx-4 text-slate-700">Students List</h1>

        <v-spacer></v-spacer>

        <v-text-field v-model="search" density="compact" label="Search" prepend-inner-icon="mdi-magnify"
          variant="solo-filled" flat hide-details single-line class="mb-5"></v-text-field>
      </v-card-title>


      <v-sheet border rounded class="overflow-y-auto max-h-[80vh]">
        <v-data-table :headers="headers" :items="students" :search="search" fixed-header height="580px">
          <template v-slot:top>
            <v-toolbar flat>
              <v-toolbar-title>

                <h3 class="text-2xl text-slate-500 ml-1">Track, Update, and Explore Student Info</h3>

              </v-toolbar-title>

              <v-btn class="mx-4" prepend-icon="mdi-plus" rounded="lg" text="Add Student" border @click="add">
              </v-btn>
            </v-toolbar>
          </template>

          <template v-slot:item.actions="{ item }">
            <div class="d-flex ga-2 justify-end">
              <v-icon color="medium-emphasis" icon="mdi-pencil" size="small" @click="edit(item.id)"></v-icon>

              <v-icon color="medium-emphasis" icon="mdi-delete" size="small" @click="remove(item.id)"></v-icon>
            </div>
          </template>

          <template v-slot:no-data>
            <v-btn prepend-icon="mdi-backup-restore" rounded="lg" text="Reset data" variant="text" border
              @click="reset"></v-btn>
          </template>
        </v-data-table>
      </v-sheet>

      <v-dialog v-model="dialog" max-width="500">
        <v-card :subtitle="`${isEditing ? 'Update' : 'Create'} the student details`"
          :title="`${isEditing ? 'Edit' : 'Add'} a Student`">
          <template v-slot:text>

            <v-alert v-if="errorMessage" type="error" class="mb-4">
              {{ errorMessage }}
            </v-alert>

            <v-row>
              <v-col cols="12">
                <v-text-field v-model="record.name" label="Name" :rules="nameRules"></v-text-field>
              </v-col>

              <v-col cols="12" md="6">
                <v-number-input v-model="record.roll_no" label="Roll No" :rules="rollNoRules"></v-number-input>
              </v-col>

              <v-col cols="12" md="6">
                <v-text-field v-model="record.className" label="Class" :rules="classNameRules"></v-text-field>
              </v-col>

              <v-col cols="12" md="6">
                <v-text-field v-model="record.city" label="City" :rules="cityRules"></v-text-field>
              </v-col>
            </v-row>
          </template>

          <v-divider></v-divider>

          <v-card-actions class="bg-surface-light">
            <v-btn text="Cancel" variant="plain" @click="dialog = false"></v-btn>

            <v-spacer></v-spacer>

            <v-btn text="Save" @click="save"></v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>

    </div>
  </div>

</template>