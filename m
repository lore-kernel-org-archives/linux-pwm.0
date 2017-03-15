From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 5/7] auxdisplay: Only descend into directory when
 CONFIG_AUXDISPLAY is set
Date: Wed, 15 Mar 2017 11:37:28 -0500
Message-ID: <20170315163730.17055-6-afd@ti.com>
References: <20170315163730.17055-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20170315163730.17055-1-afd@ti.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Richard Purdie <rpurdie@rpsys.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lauro Ramos Venancio <lauro.venancio@openbossa.org>, Aloisio Almeida Jr <aloisio.almeida@openbossa.org>, Samuel Ortiz <sameo@linux.intel.com>, kernel-janitors@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

When CONFIG_AUXDISPLAY is not set make will still descend into the
auxdisplay directory but nothing will be built. This produces unneeded
build artifacts and messages in addition to slowing the build.
Fix this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index cd92491bd76b..8a9ed5c59778 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -95,7 +95,7 @@ obj-y				+= firewire/
 obj-$(CONFIG_UIO)		+= uio/
 obj-$(CONFIG_VFIO)		+= vfio/
 obj-y				+= cdrom/
-obj-y				+= auxdisplay/
+obj-$(CONFIG_AUXDISPLAY)	+= auxdisplay/
 obj-$(CONFIG_PCCARD)		+= pcmcia/
 obj-$(CONFIG_DIO)		+= dio/
 obj-$(CONFIG_SBUS)		+= sbus/
-- 
2.11.0
