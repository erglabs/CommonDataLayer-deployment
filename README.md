
## Horust

Tested only on unix-like systems, ( gentoo, debian, HURD-6.1 )

### Setup

TODO: Wait until my changes in Horust gets merged (https://github.com/FedericoPonzi/Horust/pull/56)

```
cargo install horust
```

We need a softlink to your CDL repo create it in root of this repo, this process will be later automated
`ln -s /path/to/your/repo/CommonDataLayer cdl`

We need debug build present, (also, yes, debug, currently service files are made for debug only)
```
cd cdl
cargo build --all --all-features
```

### Infrastructure
start all necessary dependencies with logging output to console
```
docker-compose -f compose/docker-compose.yml up postgres kafka
```

alternatively start as daemons  only use when the deployment is stable on your setup
```
docker-compose -f compose/docker-compose.yml up -d postgres kafka
```

### Start Deployment

```
horust --services-path bare/horust/kafka/base --services-path bare/horust/kafka/postgres &
```

### Examples
Examples expect to be ran from this directory

``` sh
./examples/horust-kafka-postgres.sh

```

### Logs
Logs are placed in the `logs` subfolder where you run the horust from

in case of problems with EONET or some other problem, good changes are
that its either missing exec or not existing directory

there are some docs about service files available here https://github.com/FedericoPonzi/Horust

To see whats going on in horust itself use
`HORUST_LOG=info horust ...`

