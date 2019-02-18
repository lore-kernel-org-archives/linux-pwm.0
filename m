From: Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 7/8] dt-bindings: iio/counter: ftm-quaddec: add poll-interval
 parameter
Date: Mon, 18 Feb 2019 15:03:20 +0100
Message-ID: <20190218140321.19166-7-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Esben Haabendal <esben@haabendal.dk>, William Breathitt Gray <vilhelm.gray@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Patrick Havelange <patrick.havelange@essensium.com>
List-Id: linux-pwm@vger.kernel.org

New optional parameter supported by updated driver.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 .../devicetree/bindings/iio/counter/ftm-quaddec.txt       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
index 4d18cd722074..60554e6c4367 100644
--- a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
+++ b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
@@ -6,8 +6,14 @@ Required properties:
 - compatible:		Must be "fsl,ftm-quaddec".
 - reg:			Must be set to the memory region of the flextimer.
 
-Optional property:
+Optional properties:
 - big-endian:		Access the device registers in big-endian mode.
+- poll-interval		Poll interval time in milliseconds for detecting
+			the under/overflow of the counter. Default value
+			is 100.
+			A value of 0 disables polling. This value can also
+			be set at runtime, but not to less than this initial
+			value (except 0 for disabling).
 
 Example:
 		counter0: counter@29d0000 {
-- 
2.17.1
