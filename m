From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v2 2/5] Documentation: bindings: document the Berlin PWM driver
Date: Thu, 30 Jul 2015 11:23:18 +0200
Message-ID: <1438248201-29222-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1438248201-29222-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438248201-29222-1-git-send-email-antoine.tenart@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: sebastian.hesselbarth@gmail.com, thierry.reding@gmail.com
Cc: zmxu@marvell.com, jszhang@marvell.com, linux-pwm@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Following the addition of a Berlin PWM driver, this patch adds the
corresponding documentation.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/pwm/pwm-berlin.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-berlin.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-berlin.txt b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
new file mode 100644
index 000000000000..3d7ab7bfbf54
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
@@ -0,0 +1,15 @@
+Berlin PWM controller
+
+Required properties:
+- compatible: should be "marvell,berlin-pwm"
+- reg: physical base address and length of the controller's registers
+- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+  the cells format.
+
+Example:
+
+pwm: pwm@f7f20000 {
+	compatible = "marvell,berlin-pwm";
+	reg = <0xf7f20000 0x40>;
+	#pwm-cells = <3>;
+}
-- 
2.5.0
