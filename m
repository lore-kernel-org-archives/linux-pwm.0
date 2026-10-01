Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93D4949E0;
	Thu,  1 Oct 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873788; cv=none; b=N6eWWPlg6aT4hqN0iZYUmKCEHR1pD+INKyqblsvZmhlqDCyR7BIza1ucdTtb2CUbNdOPAyVyJ8vsvV32fXBCuJpwDKIhxv/pBVtXtQmOrEufj0o1ZKRvffLUIXQKGAhQUbKbmwl+29/x4oU3pLROd36pSCDGWmAceq5QpMENh3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873788; c=relaxed/simple;
	bh=XZs+OjUq8Qpi5yTikP3J4NzLgAxgZQOZ2rAk6yNAXsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=emA3R6myLLCWzdkjH/GEmEIGDK54iCPIIEQ/NCk+8HFtN34qeVyHfD1E6l6TC+IG/dmr3HzpzfTqcBMOLz25ByH2wUnETrHcn5A1bnBI5qsvhlh0Ehoxmj++9waHGS/HwTUs+hUE7BXiZrHvDos0B6zzDe+2W9qDaKsW1nALIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2uU6Xw+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2uU6Xw+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F6F7C4AF18;
	Thu,  1 Oct 2026 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790873788;
	bh=XZs+OjUq8Qpi5yTikP3J4NzLgAxgZQOZ2rAk6yNAXsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R2uU6Xw+xCfIbF5sL5YlRmrUf9JdJtFgt/am0N9EfzTwxjtBiO6M3PmJw/1ixpPO4
	 AnL9j/AdoWKhLwzJJU11R2MwMrAfrjzxzE2T8zWY2X4MxypqjDO6qi6z9+/wrmQapE
	 qPTmKQz8MhZ80WVJsPXrW4Q2vHgFDcOirQpaIZ3tvHrfsY692mvIcgduSuy+jbEcBn
	 xwU4FP84bSD6tf5p65lhT/eyY9FDZhS6y+Tr+FJ93GsI99l5X/kemvolAsdlu0TKZl
	 +9Pe/cFVKGpVDWImvkoj0ZvozGaqpNguJJ0XarHCj2JwEIJUuxPNzdShXkb5CV7meL
	 I3nMKpU4P5Wbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C17CA5FD4;
	Thu,  1 Oct 2026 16:56:28 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 01 Oct 2026 18:55:36 +0200
Subject: [PATCH v4 3/3] arm64: dts: amlogic: a1-c3-s4-t7: Add bus clock to
 PWM controller nodes
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-add-t7-sys-pwm-clk-v4-3-8ed2b1e0cdfe@aliel.fr>
References: <20261001-add-t7-sys-pwm-clk-v4-0-8ed2b1e0cdfe@aliel.fr>
In-Reply-To: <20261001-add-t7-sys-pwm-clk-v4-0-8ed2b1e0cdfe@aliel.fr>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10307;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=0noFD4QaLLZlEqbQPJmnIuc/5yYJNcuXmbeBKVxdegY=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9a+CdutD7Q6Pzq7s+L5l+Z916enJt3jtyj0M3jnffF7+
 r4OQWOmjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAimhIM/0w/zX55Ku7Z3pzf
 +srntZZsW8r5+w3Pms22hS+Zunv6Ns5hZGg6WlPkpSKyY0bH5PBAE5mn53RnaFhwrGU5kLiuVEV
 ajhEA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Describe the system clock of each PWM controller as a third clock,
and add the clock-names property expected by the updated binding:
"channel-a", "channel-b" and "bus".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 28 +++++++++++++++++++++-------
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 28 +++++++++++++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi   | 12 +++++++++---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi   | 20 +++++++++++++++-----
 4 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index 4e6757a57fb9a..2de68d2a2fb53 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -824,7 +824,9 @@ pwm_mn: pwm@54000 {
 					     "amlogic,meson-s4-pwm";
 				reg = <0x0 0x54000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_M>,
-					 <&clkc_periphs CLKID_PWM_N>;
+					 <&clkc_periphs CLKID_PWM_N>,
+					 <&clkc_periphs CLKID_SYS_PWM_MN>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -843,7 +845,9 @@ pwm_ab: pwm@58000 {
 					     "amlogic,meson-s4-pwm";
 				reg = <0x0 0x58000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_A>,
-					 <&clkc_periphs CLKID_PWM_B>;
+					 <&clkc_periphs CLKID_PWM_B>,
+					 <&clkc_periphs CLKID_SYS_PWM_AB>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -853,7 +857,9 @@ pwm_cd: pwm@5a000 {
 					     "amlogic,meson-s4-pwm";
 				reg = <0x0 0x5a000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_C>,
-					 <&clkc_periphs CLKID_PWM_D>;
+					 <&clkc_periphs CLKID_PWM_D>,
+					 <&clkc_periphs CLKID_SYS_PWM_CD>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -863,7 +869,9 @@ pwm_ef: pwm@5c000 {
 					     "amlogic,meson-s4-pwm";
 				reg = <0x0 0x5c000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_E>,
-					 <&clkc_periphs CLKID_PWM_F>;
+					 <&clkc_periphs CLKID_PWM_F>,
+					 <&clkc_periphs CLKID_SYS_PWM_EF>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -873,7 +881,9 @@ pwm_gh: pwm@5e000 {
 					     "amlogic,meson-s4-pwm";
 				reg = <0x0 0x5e000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_G>,
-					 <&clkc_periphs CLKID_PWM_H>;
+					 <&clkc_periphs CLKID_PWM_H>,
+					 <&clkc_periphs CLKID_SYS_PWM_GH>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -883,7 +893,9 @@ pwm_ij: pwm@60000 {
 					     "amlogic,meson-s4-pwm";
 				reg = <0x0 0x60000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_I>,
-					 <&clkc_periphs CLKID_PWM_J>;
+					 <&clkc_periphs CLKID_PWM_J>,
+					 <&clkc_periphs CLKID_SYS_PWM_IJ>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -893,7 +905,9 @@ pwm_kl: pwm@62000 {
 					     "amlogic,meson-s4-pwm";
 				reg = <0x0 0x62000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_K>,
-					 <&clkc_periphs CLKID_PWM_L>;
+					 <&clkc_periphs CLKID_PWM_L>,
+					 <&clkc_periphs CLKID_SYS_PWM_KL>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 8f3f1c0579a0f..92fd7e6e6a84f 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -692,7 +692,9 @@ pwm_ao_ef: pwm@30000 {
 				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
 				reg = <0x0 0x30000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_AO_E>,
-					 <&clkc_periphs CLKID_PWM_AO_F>;
+					 <&clkc_periphs CLKID_PWM_AO_F>,
+					 <&clkc_periphs CLKID_SYS_PWM_AO_EF>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -701,7 +703,9 @@ pwm_ao_gh: pwm@32000 {
 				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
 				reg = <0x0 0x32000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_AO_G>,
-					 <&clkc_periphs CLKID_PWM_AO_H>;
+					 <&clkc_periphs CLKID_PWM_AO_H>,
+					 <&clkc_periphs CLKID_SYS_PWM_AO_GH>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -715,7 +719,9 @@ pwm_ab: pwm@58000 {
 				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
 				reg = <0x0 0x58000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_A>,
-					 <&clkc_periphs CLKID_PWM_B>;
+					 <&clkc_periphs CLKID_PWM_B>,
+					 <&clkc_periphs CLKID_SYS_PWM_AB>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -724,7 +730,9 @@ pwm_cd: pwm@5a000 {
 				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
 				reg = <0x0 0x5a000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_C>,
-					 <&clkc_periphs CLKID_PWM_D>;
+					 <&clkc_periphs CLKID_PWM_D>,
+					 <&clkc_periphs CLKID_SYS_PWM_CD>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -733,7 +741,9 @@ pwm_ef: pwm@5c000 {
 				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
 				reg = <0x0 0x5c000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_E>,
-					 <&clkc_periphs CLKID_PWM_F>;
+					 <&clkc_periphs CLKID_PWM_F>,
+					 <&clkc_periphs CLKID_SYS_PWM_EF>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -742,7 +752,9 @@ pwm_ao_ab: pwm@5e000 {
 				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
 				reg = <0x0 0x5e000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_AO_A>,
-					 <&clkc_periphs CLKID_PWM_AO_B>;
+					 <&clkc_periphs CLKID_PWM_AO_B>,
+					 <&clkc_periphs CLKID_SYS_PWM_AO_AB>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -751,7 +763,9 @@ pwm_ao_cd: pwm@60000 {
 				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
 				reg = <0x0 0x60000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_AO_C>,
-					 <&clkc_periphs CLKID_PWM_AO_D>;
+					 <&clkc_periphs CLKID_PWM_AO_D>,
+					 <&clkc_periphs CLKID_SYS_PWM_AO_CD>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 6f6a6145cba12..a224cbc959e45 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -544,7 +544,9 @@ pwm_ab: pwm@2400 {
 				reg = <0x0 0x2400 0x0 0x24>;
 				#pwm-cells = <3>;
 				clocks = <&clkc_periphs CLKID_PWM_A>,
-					 <&clkc_periphs CLKID_PWM_B>;
+					 <&clkc_periphs CLKID_PWM_B>,
+					 <&clkc_periphs CLKID_PWM_AB>;
+				clock-names = "channel-a", "channel-b", "bus";
 				power-domains = <&pwrc PWRC_I2C_ID>;
 				status = "disabled";
 			};
@@ -555,7 +557,9 @@ pwm_cd: pwm@2800 {
 				reg = <0x0 0x2800 0x0 0x24>;
 				#pwm-cells = <3>;
 				clocks = <&clkc_periphs CLKID_PWM_C>,
-					 <&clkc_periphs CLKID_PWM_D>;
+					 <&clkc_periphs CLKID_PWM_D>,
+					 <&clkc_periphs CLKID_PWM_CD>;
+				clock-names = "channel-a", "channel-b", "bus";
 				power-domains = <&pwrc PWRC_I2C_ID>;
 				status = "disabled";
 			};
@@ -655,7 +659,9 @@ pwm_ef: pwm@5400 {
 				reg = <0x0 0x5400 0x0 0x24>;
 				#pwm-cells = <3>;
 				clocks = <&clkc_periphs CLKID_PWM_E>,
-					 <&clkc_periphs CLKID_PWM_F>;
+					 <&clkc_periphs CLKID_PWM_F>,
+					 <&clkc_periphs CLKID_PWM_EF>;
+				clock-names = "channel-a", "channel-b", "bus";
 				power-domains = <&pwrc PWRC_I2C_ID>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index 2a6fbd5308362..537e269642905 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -685,7 +685,9 @@ pwm_ab: pwm@58000 {
 				compatible = "amlogic,meson-s4-pwm";
 				reg = <0x0 0x58000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_A>,
-					 <&clkc_periphs CLKID_PWM_B>;
+					 <&clkc_periphs CLKID_PWM_B>,
+					 <&clkc_periphs CLKID_PWM_AB>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -694,7 +696,9 @@ pwm_cd: pwm@5a000 {
 				compatible = "amlogic,meson-s4-pwm";
 				reg = <0x0 0x5a000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_C>,
-					 <&clkc_periphs CLKID_PWM_D>;
+					 <&clkc_periphs CLKID_PWM_D>,
+					 <&clkc_periphs CLKID_PWM_CD>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -703,7 +707,9 @@ pwm_ef: pwm@5c000 {
 				compatible = "amlogic,meson-s4-pwm";
 				reg = <0x0 0x5c000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_E>,
-					 <&clkc_periphs CLKID_PWM_F>;
+					 <&clkc_periphs CLKID_PWM_F>,
+					 <&clkc_periphs CLKID_PWM_EF>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -712,7 +718,9 @@ pwm_gh: pwm@5e000 {
 				compatible = "amlogic,meson-s4-pwm";
 				reg = <0x0 0x5e000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_G>,
-					 <&clkc_periphs CLKID_PWM_H>;
+					 <&clkc_periphs CLKID_PWM_H>,
+					 <&clkc_periphs CLKID_PWM_GH>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -721,7 +729,9 @@ pwm_ij: pwm@60000 {
 				compatible = "amlogic,meson-s4-pwm";
 				reg = <0x0 0x60000 0x0 0x24>;
 				clocks = <&clkc_periphs CLKID_PWM_I>,
-					 <&clkc_periphs CLKID_PWM_J>;
+					 <&clkc_periphs CLKID_PWM_J>,
+					 <&clkc_periphs CLKID_PWM_IJ>;
+				clock-names = "channel-a", "channel-b", "bus";
 				#pwm-cells = <3>;
 				status = "disabled";
 			};

-- 
2.49.0


