Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813066;
	b=ZaPDCrGiZZY8YVMLVvCu08iTm3wku2vgAD5OdEY6KceKh02Ci0LzlY1N9jJ6gMZbDCff
	 EZ16KLhIJY69XTIhSrj0HhrXPy45MG5jEpG6wOcbW5sw/rKtViGVNfleuO3zepenciA7q
	 4ViXkgBPQz1+vu0U/D5rCyXXqos4lK3lm/DO2IAPvmXzgTP4XGZUTQ3yoI5r+DwXtcYqy
	 hmLqd5Zi6d6HpvcnexuI8MXbqH78NcGZdt9i/hHxUZd5fd6jpu2E3eYJO7jy6lk95MhLR
	 kTuL6N+LtY4oF6n6jXeBnJsSq0rWOVrr2iv74pevTYGqOsAnCdncinCgZJOqrnK1gSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813066;
	h=DMARC-Filter:From:DKIM-Signature:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc;
	bh=ProipenWM1wsykY7V3fdTvREC7WOIdzWpyQEuX+SOqo=;
	b=kVmXtTQLnOgrMagRAIJOF9Jn4vsDcu3aCTuKF7Drxhht7gDW7+JLkzr2oV3wt2NYSzrt
	 /fH5Hdi7sBa63mseW0yx7pPYTSnIV6lKnw8HcHc3b8QbH4Y3lAedWY2aICefBQ0QSff3r
	 GHYbrvAdJrV9IsQokewmwFSF+bh2Dbl0AAUhZYnoLiCAt67ZUPw1AffU+YmnSx6wNSe0I
	 eBa7K8Uw0g+NxGcmFRqRO2fGT86MT3hIQeqFWfSBRdWg9AfoRVunVca749IsFHOFVzf9T
	 gGdG0OKtoPQVndIlXZxgHKbVuwzq/R/sbp4bJvWLn1z1qv/MBOyt2UkGmJCUvhpFvGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b="wg6FE/U5";
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D4606A326;
	Wed,  4 Nov 2026 17:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F26D4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=wg6FE/U5
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793813061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ProipenWM1wsykY7V3fdTvREC7WOIdzWpyQEuX+SOqo=;
	b=wg6FE/U535xAqcV/smG3wF/uGO6wTvQMZGhOdf9od3sA8JWLM7ckyDoP+lG9NX0jNCyJmZ
	AxSPdzrYw1sVf/zQ3wuXy7wv0qpQlB0Ndo1cqgcppNag7faXln6WNaQ6vFxt3FtBntYdz/
	2CDFuc2ChXyNAOx1mfXg3dzjQWe0qtc=
Subject: [PATCH v2 0/9] Initial Apple Silicon M5 device trees and
 dt-bindings
Date: Wed, 04 Nov 2026 18:24:13 +0100
Message-Id: <20261104-apple-m5-initial-devicetrees-v2-0-fd727a82d380@cyberchaos.dev>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Pyw6CMBBFf4V07Zi2WFBX/odhQdtRxiBgW4iE8
 O+Wx9rlTe6cc2diHh2hZ9dkYg4H8tQ2MchDwkxVNk8EsjEzyWUmuMig7Loa4a2AGgpU1mDjlcH
 gED2cLHJ9ydVFp5pFROfwQd8Vfy+27Hv9QhMW5tKoyIfWjat/EEtvV8n8v2oQwEGkKhNnoY3i9
 mZGjS6Obv0xFlkxb0KHnz6+FfYV8/wDpk9Fl/QAAAA=
X-Change-ID: 20261016-apple-m5-initial-devicetrees-4de0b9759b3b
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hector Martin <marcan@marcan.st>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Yureka Lilian <yureka@cyberchaos.dev>, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Hi,

This series adds initial device trees and dt-bindings for the Apple
Silicon devices using the M5 (t8142) SoCs.

This series covers only a minimal amount of hardware, which is useful
as a basis for future developments. The hardware added here has remained
largely unchanged from the earlier Apple Silicon generations.

I applied some version of dt-check-style formatting to all new files
with the exception of the generated pmgr nodes.

Merge strategy:
Since there are no actual driver changes, we'd prefer to merge the
dt-bindings changes through the apple-soc tree once Acked by the
respective maintainers.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
Changes in v2:
- Dropped the watchdog dt-bindings commit, as it's been applied to the
  watchdog tree
- Fixed ordering of pinctrl dt-bindings list
- Link to v1: https://patch.msgid.link/20261027-apple-m5-initial-devicetrees-v1-0-1356181bc50d@cyberchaos.dev

To: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>
To: Neal Gompa <neal@gompa.dev>
To: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <radu@rendec.net>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Hector Martin <marcan@marcan.st>
To: Uwe Kleine-König <ukleinek@kernel.org>
To: Sasha Finkelstein <k@chaosmail.tech>
To: Linus Walleij <linusw@kernel.org>
To: Mark Kettenis <kettenis@openbsd.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-i2c@vger.kernel.org

---
Yureka Lilian (9):
      dt-bindings: interrupt-controller: apple,aic2: Add t8142 compatible
      dt-bindings: arm: cpus: Add Apple M5 CPU core compatibles
      dt-bindings: arm: power: apple,pmgr-pwrstate: Add t8142 compatible
      dt-bindings: arm: apple: apple,pmgr: Add t8142 compatible
      dt-bindings: pwm: apple,s5l-fpwm: Add t8142 compatible
      dt-bindings: pinctrl: apple,pinctrl: Add t8142 compatible
      dt-bindings: i2c: apple,i2c: Add t8142 compatible
      dt-bindings: arm: apple: Add M5 based devices
      arm64: dts: apple: Add minimal t8142 (M5) device trees

 Documentation/devicetree/bindings/arm/apple.yaml   |   15 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    1 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    1 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |    1 +
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    3 +
 .../bindings/power/apple,pmgr-pwrstate.yaml        |    1 +
 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    1 +
 arch/arm64/boot/dts/apple/Makefile                 |    3 +
 arch/arm64/boot/dts/apple/t8142-j704.dts           |   36 +
 arch/arm64/boot/dts/apple/t8142-j813.dts           |   36 +
 arch/arm64/boot/dts/apple/t8142-j815.dts           |   36 +
 arch/arm64/boot/dts/apple/t8142-jxxx.dtsi          |   50 +
 arch/arm64/boot/dts/apple/t8142-pmgr.dtsi          | 1131 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8142.dtsi               |  512 +++++++++
 15 files changed, 1829 insertions(+)
---
base-commit: b01f6764df0254308bf0c33b9f7ef01ef4975d28
change-id: 20261016-apple-m5-initial-devicetrees-4de0b9759b3b

Best regards,
--  
Yureka Lilian <yureka@cyberchaos.dev>

