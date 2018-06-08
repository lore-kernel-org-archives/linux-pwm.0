From: shenwei.wang@nxp.com
Subject: [PATCH v2 4/4] dt-bindings: pwm: fsl-ftm: Add compatible string for i.MX8QM
Date: Fri,  8 Jun 2018 14:22:37 -0500
Message-ID: <20180608192237.11063-4-shenwei.wang@nxp.com>
References: <20180608192237.11063-1-shenwei.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180608192237.11063-1-shenwei.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
List-Id: linux-pwm@vger.kernel.org

i.MX8QM integrates a new version of FTM IP block. It adds eight
PWM enable bits in FTM_SC register.
Add a new compatible string of "fsl,imx8qm-ftm-pwm" for i.MX8QM
to differentiate it from the previous SoCs.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
index 3899d6a..576ad00 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
@@ -16,7 +16,10 @@ modes in device tree.
 
 
 Required properties:
-- compatible: Should be "fsl,vf610-ftm-pwm".
+- compatible : should be "fsl,<soc>-ftm-pwm" and one of the following
+   compatible strings:
+  - "fsl,vf610-ftm-pwm" for PWM compatible with the one integrated on VF610
+  - "fsl,imx8qm-ftm-pwm" for PWM compatible with the one integrated on i.MX8QM
 - reg: Physical base address and length of the controller's registers
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
-- 
2.9.2
