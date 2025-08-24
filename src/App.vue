<template>
  <div class="login-container">
    <h2>Login</h2>
    <form @submit.prevent="handleLogin">
      <div class="form-group">
        <label for="email">Email:</label>
        <input v-model="email" type="email" id="email" required />
      </div>

      <div class="form-group">
        <label for="password">Password:</label>
        <input v-model="password" type="password" id="password" required />
      </div>

      <button type="submit" :disabled="loading">Login</button>

      <p v-if="error" class="error">{{ error }}</p>
      <p v-if="loading" class="loading">Logging in...</p>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const email = ref('');
const password = ref('');
const error = ref('');
const loading = ref(false);

const handleLogin = async () => {
  error.value = '';
  loading.value = true;

  if (!email.value || !password.value) {
    error.value = 'Both fields are required.';
    loading.value = false;
    return;
  }

  try {
    // Simulate API call with a timeout
    await new Promise((resolve) => setTimeout(resolve, 2000));

    // Simulate success or failure
    if (email.value === 'test@example.com' && password.value === 'password') {
      console.log('Login successful:', { email: email.value, password: password.value });
      // Redirect user or handle post-login logic
    } else {
      error.value = 'Invalid credentials. Please try again.';
    }
  } catch (err) {
    error.value = 'An error occurred. Please try again later.';
  } finally {
    loading.value = false;
  }
};
</script>

<style scoped>
.login-container {
  max-width: 400px;
  margin: 100px auto;
  padding: 2rem;
  border: 1px solid #ccc;
  border-radius: 8px;
  font-family: Arial, sans-serif;
  background: #f9f9f9;
}
h2 {
  text-align: center;
}
.form-group {
  margin-bottom: 1rem;
}
label {
  display: block;
  margin-bottom: 0.5rem;
}
input {
  width: 100%;
  padding: 0.5rem;
  box-sizing: border-box;
}
button {
  width: 100%;
  padding: 0.75rem;
  background-color: #42b983;
  border: none;
  color: white;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.3s;
}
button:hover {
  background-color: #369f6e;
}
button:disabled {
  background-color: #aaa;
  cursor: not-allowed;
}
.error {
  color: red;
  margin-top: 1rem;
  text-align: center;
}
.loading {
  color: #42b983;
  text-align: center;
  margin-top: 1rem;
}
</style>
