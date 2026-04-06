Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9972F9985;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775507137; cv=none; b=ezn6hycoQU4Uy9cylkgpT1cIJSJ+hLkf04Mxmflxop32irRTqACyyjaXBDCRCCJKTENGFLu9JwgDgEp3yv/lO2Tx/2JIetJ9l8/2PgZMkxLn3pYsO3kT7sBOcIjFRG/9aOrPW0XgTF6xD16qvHVdXFTNAMq/aFhEBzttY5HeJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775507137; c=relaxed/simple;
	bh=vY+msfSpuSB0jDw6x5AYAD4LtNsvmSIBHHnDm/9oW0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tU/bIlqHIhrcrvRqw5jZRzb/R/BMNduWnH5jFdYEVzHZRF5cv1vpBcwbYBb5iiLyVfMAL22f8W8hHxw3ycer9eRPnt7Qb8wkBA6BdPQyB3K+udEcyBJgjrqCPdAAhLzcIENHt5CkWDqlkBKrJlMB1REPWI9osUQlAm+QMKoD5K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpWzqBd3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpWzqBd3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D3DBC2BCB5;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775507137;
	bh=vY+msfSpuSB0jDw6x5AYAD4LtNsvmSIBHHnDm/9oW0w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rpWzqBd39rxWR4Sbo+ks6Nqp1m5At37BAHCU7uUkeTcUISZlyGzReQI7Evr4jeL2B
	 MyreQUKG/KHfoWblP+1OwMA9T54HIAEqp2cs6XpUDtKU/r/m3irc4W0zL6YnOYE+C/
	 yV6kw3L6WBplFIctkbS0nhMpDjhnXWCB9soX+2t+msZJZM9TPwkUPYNjjEu9MZRbYD
	 sEhkm2Q8los78LI/HkR58UmMGxPEYZ866Wb0sqybkywv9fVHjNkgQ32FyCGLYdL2h7
	 dDrvoXAjtWFRjOg5HCm2D484YYSPiLisjUeTgG9tAhV34JSgcYwjYzkCE5xL6xAezU
	 kAy/P68hUSBxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84589FB5168;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 06 Apr 2026 22:24:41 +0200
Subject: [PATCH v21 4/6] arm64: dts: qcom: ipq5018: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-ipq-pwm-v21-4-6ed1e868e4c2@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775507135; l=1238;
 i=george.moussalem@outlook.com; s=20260406; h=from:subject:message-id;
 bh=Q3Kni45lqsYFrwlIKyqfk0z6yh8vt/BwrVScgBSze6s=;
 b=fBxEPiCugHIQg0LwhaaK7nTTlhEPCk4139ehZNq13093fuLZ05hrjiKW7DJ/E2L8/9e9eCcYu
 vvqOEKb6aDJAmom01ZPGzhNlB0CkJqLfc6TKlwSwYmmlUoSiKXWCRaP
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=uqspem3ahtBvPEBuxVbyyXT/0Vp3JNb/mo1EPbmBzWg=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20260406
 with auth_id=722
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Describe the PWM block on IPQ5018.

Although PWM is in the TCSR area, make pwm its own node as simple-mfd
has been removed from the bindings and as such hardware components
should have its own node.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 6f8004a22a1f..edff89257468 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -453,6 +453,16 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x21000>;
 		};
 
+		pwm: pwm@1941010 {
+			compatible = "qcom,ipq5018-pwm", "qcom,ipq6018-pwm";
+			reg = <0x01941010 0x20>;
+			clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clock-rates = <100000000>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		sdhc_1: mmc@7804000 {
 			compatible = "qcom,ipq5018-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x7804000 0x1000>;

-- 
2.39.5


