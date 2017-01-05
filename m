From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 6/6] [media] Only descend into directory when
 CONFIG_MEDIA_SUPPORT is set
Date: Thu, 5 Jan 2017 15:01:58 -0600
Message-ID: <20170105210158.14204-7-afd@ti.com>
References: <20170105210158.14204-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20170105210158.14204-1-afd@ti.com>
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
To: Russell King <linux@armlinux.org.uk>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Richard Purdie <rpurdie@rpsys.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lauro Ramos Venancio <lauro.venancio@openbossa.org>, Aloisio Almeida Jr <aloisio.almeida@openbossa.org>, Samuel Ortiz <sameo@linux.intel.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

When CONFIG_MEDIA_SUPPORT is not set make will still descend into the
media directory but nothing will be built. This produces unneeded build
artifacts and messages in addition to slowing the build. Fix this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 59d6e0f5643d..9ccec4924ad1 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -109,7 +109,8 @@ obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_RTC_LIB)		+= rtc/
-obj-y				+= i2c/ media/
+obj-y				+= i2c/
+obj-$(CONFIG_MEDIA_SUPPORT)	+= media/
 obj-$(CONFIG_PPS)		+= pps/
 obj-y				+= ptp/
 obj-$(CONFIG_W1)		+= w1/
-- 
2.11.0
