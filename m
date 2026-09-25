Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D0A4CC600;
	Fri, 25 Sep 2026 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349266; cv=none; b=shZ4SPI46XFXSS4sQz6fn1CSHVN8EDGbooYBf9kfgiAaUq1v63HMCUpQ5pnLvT/SNqONkQ4FqzSWZqWHeQg9l/IsLhiPOX0CwIjR8moDu351Qb+v3pSLnjyaxE4D3rsTFiBgNSwyCupnh4r9eErPNnMGFKxXNh0AM7pLyOJrX+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349266; c=relaxed/simple;
	bh=BvV2GQqzvOzgjsW3tDmxKxPUarEcjrPWBP2eqzE21fM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lQ1hW4WaRraJ11zvOSR7Z9Sx/QzXhTijFmhsQSpQkkR02EmOvW/cyhnY/BuqbFR5ERnXN9kjpHPumAutUArAFWo7wEsQj+5PkG75jNX+7Cu9o48yl9hBUO4ij6Mjg3Fth0VkuKYWJPz+WWrqsL77LsujMjNcDQAhxnZ+jVf0FUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJPhbiGC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJPhbiGC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51B6BC2BCF6;
	Fri, 25 Sep 2026 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790349264;
	bh=BvV2GQqzvOzgjsW3tDmxKxPUarEcjrPWBP2eqzE21fM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=HJPhbiGCgTKJl9zwGOsbB3OCygkhlc0nDWIjZ+o81/WAbXfGsCZuxVe6slSQTokBd
	 Afww3f7JtX/TYaE9uC9UydeWe6Xm7ULlFYVZ6K460HaUYbY9uhYrFwY3jzPiBdHVNl
	 69XG6E4H08RTz4ayDTzSUTkAPS5+47D9uNW9+bd7GqbiqMdisnrvmoT2JiyXUYYKFS
	 XhQBDPHGXsCokS1B59tHuYDKWf11axooYcWXIRicqUbCfTtt0ErVBCtribbBT3ibHw
	 jv7SkN5i4civLMmYuBSuHbatIyz7gTqq/lFze0RnX2KOus8v8Pu6Npp2dDepB0DI5/
	 dpLfR2Orl5SKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1BEC98325;
	Fri, 25 Sep 2026 15:14:24 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Subject: [PATCH v2 0/3] Add T7 PWM core clock support
Date: Fri, 25 Sep 2026 17:13:27 +0200
Message-Id: <20260925-add-t7-sys-pwm-clk-v2-0-f23a22b71a5c@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7Zi2UaGuvIdhUehUJlYgLakS0
 rtbOYDL95L//gaRAlOEa7VBoMSRp7GAOlTQD2Z8ELItDEqoi9DqhMZaXGqMa8T5/cLeP9EJcq6
 RHZGSUIZzIMefPXpvCw8clyms+0eSP/s3lyQKFOdOS2pqJ4y+Gc/kjy5Am3P+AkX83omzAAAA
X-Change-ID: 20260924-add-t7-sys-pwm-clk-f0eff81bee21
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2113;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=BvV2GQqzvOzgjsW3tDmxKxPUarEcjrPWBP2eqzE21fM=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9a2/l2i6w8dObVVRbIk5sXWuS//fDL1KMnwNvgg+Nppg
 8mzr3t8O0pZGMS4GGTFFFn651qeeHf56Jmve9RTYOawMoEMYeDiFICJeKcxMhzofRLKF3mzWUP3
 6iQV97xpf3bvcxA7fktmUcQ883mNfEUM/2P/RN7w3ty3Nf/rlZwv9+Y9CklbxLbw27Vqnj+HGzb
 ceMMOAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

The PWM controllers on the Amlogic T7 SoC have a system clock that
controls access to the controller, in addition to the two input
clocks of channels A and B.

It is currently not described in the device tree, so it is neither
referenced nor enabled by the driver.

This series adds support for it:

  - patch 1 extends the binding with a third "core" clock for
    amlogic,t7-pwm, and makes clocks/clock-names required for it;
  - patch 2 makes the driver get and enable the optional "core"
    clock, leaving other SoCs unaffected;
  - patch 3 describes the system clock (CLKID_SYS_PWM_*) in the T7
    device tree for all the PWM controllers.

`dt_binding_check DT_SCHEMA_FILES=pwm-amlogic.yaml` test is ok

  CHKDT   ./Documentation/devicetree/bindings
warning: python package 'yamllint' not installed, skipping
  STYLE   ./Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/pwm/pwm-amlogic.example.dts
  DTC [C] Documentation/devicetree/bindings/pwm/pwm-amlogic.example.dtb

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
Changes in v2:
- PATCH 1: Permits to use "core" clock on S4 SoC and all the ones that fallback to it.
           Rename "clk_a" and "clk_b" to "channel-a" and "channel-b". Thx to Conor's feedback.
- PATCH 3: Rename channel clock-names as done on patch 1.
- Link to v1: https://lore.kernel.org/r/20260924-add-t7-sys-pwm-clk-v1-0-05b91e87f0a9@aliel.fr

---
Ronald Claveau (3):
      dt-bindings: pwm: amlogic: Add core clock for T7
      pwm: meson: Add optional core clock for S4 PWM
      arm64: dts: amlogic: t7: Add core clock to PWM controller nodes

 .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 33 ++++++++++++++++++++--
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        | 28 +++++++++++++-----
 drivers/pwm/pwm-meson.c                            |  5 ++++
 3 files changed, 57 insertions(+), 9 deletions(-)
---
base-commit: a8c591ed6b672915e0be57843f943a2a723aff40
change-id: 20260924-add-t7-sys-pwm-clk-f0eff81bee21

Best regards,
-- 
Ronald Claveau <linux-kernel-dev@aliel.fr>


