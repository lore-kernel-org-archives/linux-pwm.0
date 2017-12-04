From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 1/3] dt-bindings: pwm: update bindings for the Meson-AXG
Date: Mon, 4 Dec 2017 14:00:16 +0800
Message-ID: <20171204060018.8856-2-yixun.lan@amlogic.com>
References: <20171204060018.8856-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171204060018.8856-1-yixun.lan@amlogic.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Jian Hu <jian.hu@amlogic.com>, Carlo Caione <carlo@caione.org>, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: linux-pwm@vger.kernel.org

From: Jian Hu <jian.hu@amlogic.com>

Update the doc to explicitly support Meson-AXG

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/pwm/pwm-meson.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
index 1ee81321c35e..1fa3f7182133 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
@@ -5,6 +5,8 @@ Required properties:
 - compatible: Shall contain "amlogic,meson8b-pwm"
                          or "amlogic,meson-gxbb-pwm"
                          or "amlogic,meson-gxbb-ao-pwm"
+                         or "amlogic,meson-axg-ee-pwm"
+                         or "amlogic,meson-axg-ao-pwm"
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
 
-- 
2.15.0
