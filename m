From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 1/7] pwm: Only descend into pwm directory when CONFIG_PWM
 is set
Date: Wed, 15 Mar 2017 11:37:24 -0500
Message-ID: <20170315163730.17055-2-afd@ti.com>
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

When CONFIG_PWM is not set make will still descend into the pwm
directory but nothing will be built. This produces unneeded build
artifacts and messages in addition to slowing the build. Fix this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 2eced9afba53..00d86749a843 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_GENERIC_PHY)	+= phy/
 # GPIO must come after pinctrl as gpios may need to mux pins etc
 obj-$(CONFIG_PINCTRL)		+= pinctrl/
 obj-$(CONFIG_GPIOLIB)		+= gpio/
-obj-y				+= pwm/
+obj-$(CONFIG_PWM)		+= pwm/
 obj-$(CONFIG_PCI)		+= pci/
 # PCI dwc controller drivers
 obj-y				+= pci/dwc/
-- 
2.11.0
