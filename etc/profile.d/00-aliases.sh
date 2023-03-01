## https://gist.github.com/jgrodziski/9ed4a17709baad10dbcd4530b60dfcbb

function dnames-fn {
	docker ps -a --format '{{.Names}}'
}

function dip-fn {
    echo "IP addresses of all named running containers"

    for DOC in `dnames-fn`
    do
        IP=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' "$DOC"`
        OUT+=$DOC'\t'$IP'\n'
    done
    echo -e $OUT | column -t
    unset OUT
}

function dex-fn {
	docker exec -it $1 ${2:-bash}
}

function dcex-fn {
	docker compose exec -it $1 ${2:-bash}
}

function di-fn {
	docker inspect $1
}

function dv-fn {
	docker volume ${@:-ls}
}

function dn-fn {
	docker network ${@:-ls}
}

function dl-fn {
	docker logs -f $1
}

function drun-fn {
	docker run -it $1 $2
}

function dcr-fn {
	docker compose run $@
}

function dsrm-fn {
	docker stop $1;docker rm $1
}

function drmc-fn {
    docker rm $(docker ps --all -q -f status=exited)
}

function drmid-fn {
    imgs=$(docker images -q -f dangling=true)
    [ ! -z "$imgs" ] && docker rmi "$imgs" || echo "no dangling images."
}

# in order to do things like dex $(dlab label) sh
function dlab {
    docker ps --filter="label=$1" --format="{{.ID}}"
}

function dc-fn {
    docker compose $*
}

alias dc=dc-fn
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcr=dcr-fn
alias dex=dex-fn
alias di=di-fn
alias dim="docker images"
alias dv=dv-fn
alias dn=dn-fn
alias dip=dip-fn
alias dl=dl-fn
alias dnames=dnames-fn
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dcps="docker compose ps"
alias dcpsa="docker compose ps -a"
alias drmc=drmc-fn
alias drmid=drmid-fn
alias drun=drun-fn
alias dsrm=dsrm-fn