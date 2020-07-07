SCRIPT =	remote-unlock

realinstall:
	${INSTALL} ${INSTALL_COPY} -o ${BINOWN} -g ${BINGRP} -m ${BINMODE} \
		${.CURDIR}/${SCRIPT} /sbin/${SCRIPT}

.include <bsd.prog.mk>
