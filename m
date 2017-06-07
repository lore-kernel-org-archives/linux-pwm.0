From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: pwm: meson: add comptabible for gxbb ao pwms
Date: Wed,  7 Jun 2017 15:30:12 +0200
Message-ID: <20170607133013.4766-2-jbrunet@baylibre.com>
References: <20170607133013.4766-1-jbrunet@baylibre.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35360 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdFGNaT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jun 2017 09:30:19 -0400
Received: by mail-wm0-f52.google.com with SMTP id x70so57997055wme.0
        for <linux-pwm@vger.kernel.org>; Wed, 07 Jun 2017 06:30:19 -0700 (PDT)
In-Reply-To: <20170607133013.4766-1-jbrunet@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

Add compatible string to properly handle the PWMs found in the AO domain
of the gxbb (and gxl) family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-meson.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
index 5376a4468cb6..5b07bebbf6f7 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
@@ -2,7 +2,9 @@ Amlogic Meson PWM Controller
 ============================
 
 Required properties:
-- compatible: Shall contain "amlogic,meson8b-pwm" or "amlogic,meson-gxbb-pwm".
+- compatible: Shall contain "amlogic,meson8b-pwm"
+                         or "amlogic,meson-gxbb-pwm"
+                         or "amlogic,meson-gxbb-ao-pwm"
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
 
-- 
2.9.4
