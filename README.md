# Trunk Yaml Cpp


- 打包 

```shell
cmake -DCMAKE_INSTALL_PREFIX=/opt/tmaps -DBUILD_SHARED_LIBS=ON ..
make -j4
make package
```

- 安装 

```shell
sudo dpkg -i packages/libtrunk_yaml_cpp_0.7.0_amd64.deb
```

- 卸载

```shell
sudo dpkg -l | grep yaml_cpp
sudo dpk -r xxx 
```