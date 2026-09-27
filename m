Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F523DD874;
	Sun, 27 Sep 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790519353; cv=none; b=THU6lmJjCnOADIOIfnGpJvb6+s+Y0nX5fGHqFQKmHoRDqgVY++SDDZ8BUKKP+qMP1oE7bCHLc63ayhPKvPGjGjOvQPw2M/9bV4V9T96fJytKTeQiW3hZvIuOMnOR4QFdvuf9Nlduyf6AEYwOEQ2QyQ0FkFhu7o6SQOvhrpQGJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790519353; c=relaxed/simple;
	bh=Bm6KfZ7u9ug9v+paHUFif7W0StQp/b1CbFmbCFUeJx8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pzlS/V0Su+uHH0Fl1QlSWB/jureSwVVRawg07/LGqNkoNopn5X+MkpU30VKEN3voRwrwNopzu76nQQxmaqTauNWUnLbRiChQfb9kbe8P5zG9T35KzcUK9kfBMMa/A4VdR4rCOaorb1k/R3z2h+DZ1nIbe0PxOiPVrbrC7LTPvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv4/psJL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv4/psJL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A807C2BCF4;
	Sun, 27 Sep 2026 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790519352;
	bh=Bm6KfZ7u9ug9v+paHUFif7W0StQp/b1CbFmbCFUeJx8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=fv4/psJLU8zK9Vhxiw3lCB1uuVJmRPsMm+rRepjXlxpzTg3ZtF2KUlnZ8nLW3YhYF
	 EjkP4ldHa2/+gH+0mI3MR5y+iv/P3rECldawgo+Jkpvnh9UTdczXcyV8JKS6eF7HQd
	 r+Wh/HXoW/uPdryOlAGOUgfffczy7RnZoM7rBE1SewjnBEdCMVz6eJxuwv63hGSaoQ
	 gWXsKa93q/L08iXBbo3kVTbRXY9/1Gt6J2jKEmuf33dHl70LsUXqfhAOAcvIixqXsf
	 m35n6gZr2JsMHDYALbdwVQjSWL9zrzFHtIE9JZw8nnpoA0WCXEuakxElKu6DG6muBV
	 pgA1s5noslE8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B4FC98332;
	Sun, 27 Sep 2026 14:29:12 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Subject: [PATCH v3 0/3] Add T7 PWM core clock support
Date: Sun, 27 Sep 2026 16:28:14 +0200
Message-Id: <20260927-add-t7-sys-pwm-clk-v3-0-18d66abea4d1@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBCF4auQrh3TDiLgynsYF6VMZSICaUmVE
 O5uYcXCuPxfMt/MwpNj8uKSzMJRYM99FyM9JMI0unsQcB1boMSzLPEEuq5hzMFPHob3C0z7BCv
 J2kJVRKhEPBwcWf5s6O0eu2E/9m7afgS1rn+5oECCzKpSUZFbqcurbpnao3Vi1QLuheyngFGwm
 GrEKlc6MzthWZYvcuDbJvUAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2647;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=Bm6KfZ7u9ug9v+paHUFif7W0StQp/b1CbFmbCFUeJx8=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9ZODbmtX2uurLDrK6qa5DL/+woWsymnbTZKrGjS/fRzj
 W7Wnn8nO0pZGMS4GGTFFFn651qeeHf56Jmve9RTYOawMoEMYeDiFICJXChl+B9b9MC+esHT1y8+
 XdK1spzyfvOSzTvXvHq5QbDIxzZB13c9w3/fZX1es8sYnEJXrDsgEPnH7UK0ydknKc1rNwmmz2S
 S8+UHAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

The PWM controllers on the Amlogic S4 SoC have a system clock that
controls access to the controller, in addition to the two input
clocks of channels A and B. The A1,C3,T7 which fallback to S4 have
this third clock too.

It is currently not described in the device tree, so it is neither
referenced nor enabled by the driver.

This series adds support for it:

  - patch 1 extends the binding with a third "core" clock for
    amlogic,meson-s4-pwm, and makes clock-names required for it;
  - patch 2 makes the driver get and enable the optional "core"
    clock, leaving existing DTS' unaffected;
  - patch 3 describes the system clock in the A1-C3-S4-T7
    device tree for all the PWM controllers.

`dt_binding_check DT_SCHEMA_FILES=pwm-amlogic.yaml` test is ok

  CHKDT   ./Documentation/devicetree/bindings
warning: python package 'yamllint' not installed, skipping
  STYLE   ./Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/pwm/pwm-amlogic.example.dts
  DTC [C] Documentation/devicetree/bindings/pwm/pwm-amlogic.example.dtb

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
Changes in v3:
- PATCH 1: Require the third clock for S4 and all SoC which fallback to it.
- PATCH 3: Add the third clock to A1, C3 and S4.
- Link to v2: https://lore.kernel.org/r/20260925-add-t7-sys-pwm-clk-v2-0-f23a22b71a5c@aliel.fr

Changes in v2:
- PATCH 1: Permits to use "core" clock on S4 SoC and all the ones that fallback to it.
           Rename "clk_a" and "clk_b" to "channel-a" and "channel-b". Thx to Conor's feedback.
- PATCH 3: Rename channel clock-names as done on patch 1.
- Link to v1: https://lore.kernel.org/r/20260924-add-t7-sys-pwm-clk-v1-0-05b91e87f0a9@aliel.fr

---
Ronald Claveau (3):
      dt-bindings: pwm: amlogic: Add core clock for S4 like
      pwm: meson: Add optional core clock for S4 PWM
      arm64: dts: amlogic: a1-c3-s4-t7: Add core clock to PWM controller nodes

 .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 21 +++++++++++++---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 28 ++++++++++++++++------
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        | 28 ++++++++++++++++------
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          | 12 +++++++---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 20 ++++++++++++----
 drivers/pwm/pwm-meson.c                            |  5 ++++
 6 files changed, 89 insertions(+), 25 deletions(-)
---
base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
change-id: 20260924-add-t7-sys-pwm-clk-f0eff81bee21

Best regards,
-- 
Ronald Claveau <linux-kernel-dev@aliel.fr>


