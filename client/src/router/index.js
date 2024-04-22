import { createRouter, createWebHistory } from "vue-router";
import {
  Home,
  Layout,
  Login,
  MyPosts,
  NewPost,
  Profile,
  RecoverPassword,
  ResetPassword,
  Signup,
} from "../views";
import { isAuthenticated } from "../auth/index";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  base: "/",
  routes: [
    {
      path: "/",
      name: "layout",
      component: Layout,
      children: [
        {
          path: "/",
          name: "home",
          component: Home,
          meta: "Home",
        },
        {
          path: "post/:id",
          name: "post",
          component: () => import("../views/Post.vue"),
        },

        {
          path: "",
          name: "private",
          beforeEnter: () => {
            if (!isAuthenticated.value) {
              return { name: "home" };
            }
          },
          children: [
            {
              path: "my-posts",
              name: "my-posts",
              component: MyPosts,
            },
            {
              path: "post/new",
              name: "new",
              component: NewPost,
            },
            {
              path: "my-account",
              name: "profile",
              component: Profile,
            },
          ],
        },

        {
          path: "",
          name: "public",
          beforeEnter: () => {
            if (isAuthenticated.value) {
              return { name: "home" };
            }
          },
          children: [
            {
              path: "/login",
              name: "login",
              component: Login,
              meta: "login",
            },
            {
              path: "signup",
              name: "signup",
              component: Signup,
              meta: "signup",
            },
            {
              path: "recover-password",
              name: "recover-password",
              component: RecoverPassword,
            },
          ],
        },
        {
          path: "password/reset/edit",
          component: ResetPassword,
          name: "reset-password",
          beforeEnter: (to, from, next) => {
            if (to.query.token) {
              next();
            } else {
              next("/");
            }
          },
        },
      ],
    },
  ],
  scrollBehavior(to, from, savedPosition) {
    return { top: 0 };
  },
});

export default router;
