From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v4 5/5] auxdisplay: Only descend into directory when
 CONFIG_AUXDISPLAY is set
Date: Tue, 5 Dec 2017 13:44:56 -0600
Message-ID: <20171205194456.23612-6-afd@ti.com>
References: <20171205194456.23612-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20171205194456.23612-1-afd@ti.com>
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
To: Thierry Reding <thierry.reding@gmail.com>, Russell King <linux@armlinux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, linuxppc-dev@lists.ozlabs.org
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
index cdf4509a2960..03cd9ceb2b3c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -98,7 +98,7 @@ obj-y				+= firewire/
 obj-$(CONFIG_UIO)		+= uio/
 obj-$(CONFIG_VFIO)		+= vfio/
 obj-y				+= cdrom/
-obj-y				+= auxdisplay/
+obj-$(CONFIG_AUXDISPLAY)	+= auxdisplay/
 obj-$(CONFIG_PCCARD)		+= pcmcia/
 obj-$(CONFIG_DIO)		+= dio/
 obj-$(CONFIG_SBUS)		+= sbus/
-- 
2.15.0
