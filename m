Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23C30DEA5;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775507137; cv=none; b=aSLDeAMT/WrunVzAdQ/DYFaCQUfxSFW6MsCffWJAF9JXpzJJfvKwlAXGK7CimfNgLm2YVNqghUZtReWhEbHevVLKO208+efN6LI7sKpCXD+lHjRIcr1aeSKUOR7147asTBN3x4pUnAvaMP3VRxpOKXtGeJLs7b+vquqK1L27dEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775507137; c=relaxed/simple;
	bh=/B2IQaLuxVrNEdJu/LPbr3v6eJv9lHIeCnJulAPSQ3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQcDRfQIBBSMeUzh+Lj239fn9FujG3fsyDohOEShtqgRZ4xDJioBlExVQl7CwSxjh3+RpFjxTAlo0gYrW5ZpbTbSidK/J/Wj9QDzXLSNHp64Y7uun6XLSkGMGp3bGFZSbyrSErESCrJMFlm9L5lLE5XjHKtvhP/H1O+I2tR8hlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwYBDj8D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwYBDj8D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1FF7C2BCB2;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775507137;
	bh=/B2IQaLuxVrNEdJu/LPbr3v6eJv9lHIeCnJulAPSQ3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hwYBDj8DwhZ75ZPw5XhPmZQ6OO0gGZXBDWQCkYxlb1dNzxEuezjOJsAhV3woXNY5w
	 JYfzpAf0OeC6HB6WUAcM2neu7TH1J5RdUs79rTbEG4tziXHkmCOFC9IGIAXqSjTk4A
	 ZMnKCRZbdA6zpaWXqWx8lxUuV0fN/RGgAH0b3OoKrpkRKoe6zIVaqSV/eR9Hu/19B6
	 owO6dv3D8vY3qu0bZRE6ln3kHhu03T7AQZfrrFAuUX1j2FWzgc8H8LHUCMEDYlv4Kw
	 D2VTrO6E9ymY6Et6vbMLT4alj+RnjUzx05GKOWhPrHBocAx7XtSViuEWIM27TwoaH3
	 sf18JpvH7Sw4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C61FB5166;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 06 Apr 2026 22:24:42 +0200
Subject: [PATCH v21 5/6] arm64: dts: qcom: ipq5332: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-ipq-pwm-v21-5-6ed1e868e4c2@outlook.com>
References: <20260406-ipq-pwm-v21-0-6ed1e868e4c2@outlook.com>
In-Reply-To: <20260406-ipq-pwm-v21-0-6ed1e868e4c2@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775507135; l=1258;
 i=george.moussalem@outlook.com; s=20260406; h=from:subject:message-id;
 bh=wArkqHV7Q7hOp/b7t2Csz+B/hx/JQeURK4X1hAhc6/s=;
 b=+btGXL0ph+olveYvqptYbxqv2iABShV57vZ6llT43p64+KvU0n4iSNCOPVrsIJ6knSOyLa9Zo
 SjDOIbJVvLYD7lvkfHRrfdzgdg1CObeFdfAF3DtvoE+fMV0t6Frpblw
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=uqspem3ahtBvPEBuxVbyyXT/0Vp3JNb/mo1EPbmBzWg=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20260406
 with auth_id=722
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Describe the PWM block on IPQ5332.

Although PWM is in the TCSR area, make pwm its own node as simple-mfd
has been removed from the bindings and as such hardware components
should have its own node.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index e227730d99a6..27504b7cfe9e 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -334,6 +334,16 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x21000>;
 		};
 
+		pwm: pwm@1941010 {
+			compatible = "qcom,ipq5332-pwm", "qcom,ipq6018-pwm";
+			reg = <0x01941010 0x20>;
+			clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clock-rates = <100000000>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		sdhc: mmc@7804000 {
 			compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;

-- 
2.39.5


