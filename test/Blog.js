const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Blog", function () {
  it("Should create a post", async function () {
    const Blog = await ethers.getContractFactory("Blog");
    const blog = await Blog.deploy("My blog");
    await blog.deployed();
    await blog.createPost("My first post", "12345");

    const posts = await blog.fetchPosts();
    expect(posts[0].title).to.equal("My first post");
  });

  it("Should edit a post", async function () {
    const Blog = await ethers.getContractFactory("Blog");
    const blog = await Blog.deploy("My blog");
    await blog.deployed();
    await blog.createPost("My Second post", "12345");

    await blog.updatePost(1, "My updated post", "23456", true);

    posts = await blog.fetchPosts();
    expect(posts[0].title).to.equal("My updated post");
  });

  it("Should add update a post name", async () => {
    const Blog = await ethers.getContractFactory("Blog");
    const blog = await Blog.deploy("My blog");
    await blog.deployed();
    expect(await blog.name()).to.equal("My blog");

    await blog.updateName("My new blog");
    expect(await blog.name()).to.equal("My new blog");
  });
});
