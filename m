Return-Path: <sergei.shtylyov@cogentembedded.com>
Return-Path: <sergei.shtylyov@cogentembedded.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] dt-bindings: pwm: renesas: pwm-rcar: document R8A779{7|8}0
 bindings
Message-ID: <7f2ce332-a128-073a-762e-fb268780a145@cogentembedded.com>
Date: Mon, 1 Oct 2018 22:57:39 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org

Document the R-Car V3{M|H} (R8A779{7|8}0) SoC in the  Renesas R-Car PWM
bindings. R8A77970's hardware is a generic R-Car gen3 PWM, while R8A77980
has an extra error injection register...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'for-next' branch of Thierry Reding's 'linux-pwm.git'
repo.

 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-pwm/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
===================================================================
--- linux-pwm.orig/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ linux-pwm/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -12,6 +12,8 @@ Required Properties:
  - "renesas,pwm-r8a7795": for R-Car H3
  - "renesas,pwm-r8a7796": for R-Car M3-W
  - "renesas,pwm-r8a77965": for R-Car M3-N
+ - "renesas,pwm-r8a77970": for R-Car V3M
+ - "renesas,pwm-r8a77980": for R-Car V3H
  - "renesas,pwm-r8a77990": for R-Car E3
  - "renesas,pwm-r8a77995": for R-Car D3
 - reg: base address and length of the registers block for the PWM.
