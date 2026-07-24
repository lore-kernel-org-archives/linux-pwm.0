Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78EA40EB89;
	Fri, 24 Jul 2026 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917015; cv=none; b=jzx+NB//9vbMqQYUnVU8Nlh9sef9E5pJtOHJ80AsOICQ1a5v1lJThKLMl8YX/wVhHUvR0QkWZ2hw/FLeiPQYylE55T9LNK+nUIt1tidKjLaH6ZHgay7OAe6MWhLc3K2R77DhrkNTyhSaCTSCVRDMkJ644LhZYb8GQqwm/sr0br8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917015; c=relaxed/simple;
	bh=OQ7Q9pVZSxs7MTqxhl4F2QNfjfU5ODNpgazXAT5XJYw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rmc589fBoRlEm87w5ONrrRJTO0bqpQ83Nev3vjKvM6NtSqJpMpNPJ2V+6YAOQxRoT8LMdSmZCnL8Lel3ZWaFr3Pr93a0r36XUCbf/rp75jxl0DVfG0eb6L0y6vjVffDNrGL7rzlRzYUZjqWOw9x39rV01N+1HuB6BNLeF32H8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=FYpp6GiF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fHFDP29i; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="FYpp6GiF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fHFDP29i"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B52AE1D0043A;
	Fri, 24 Jul 2026 14:16:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 24 Jul 2026 14:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1784917011; x=1785003411; bh=Lp
	DCBpvfhneSCSswTCQaVQxoOX+Q/l4HOtvcxJgOB8g=; b=FYpp6GiFc4daplH6Tb
	XJfRF6eqF1Z01HWphy0Wr0iuG6rHC7D5EOrNeg5NF8/D77teTBs9gMi2vObDYzEN
	cj4YgZ5qjdzZ3ek89tSXTExpsBG9mf6sPxqX3wp6kjEyH7IFfm670+pKjb23GKwc
	nbQyGCtFyYdSnbjiqX0lNts9CBydkWOvEvxfd8D4M+cJUtXiQpYVhBvJplt6wsia
	OdDVgLg33IhGFHAwreu3ynHvAY3CopWoVeIjpSi/cR1TgGyWgefwus1Jj1+IYLgU
	jlnsncLMBCkh6N6vuxty8+hVZd5bn7ze6dMxCQ8m40OFSzz3auDDuNEbWN40S1i9
	izig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784917011; x=1785003411; bh=LpDCBpvfhneSCSswTCQaVQxoOX+Q
	/l4HOtvcxJgOB8g=; b=fHFDP29i1CwzDu7+4cCvitXpffJ+ZwqVV60TC3RpP0oM
	gDFRKOh6JD1ikhPe+CL5Wo7eRRuwY+/3c3M/ZF0yBOg/DZhmajJi/zvtXfq8+pJP
	7zwZmXWGEQWNWBjCkHE2zq9YvqN2sZdYljcn+SDNCKI4x04kXMVGa9f2EyUcoX5T
	ycG0BLDkKdRIfszHtwWf2wIt9i5ijBXBdmUjcvR05kxe2XPgrjXix9O1Ck0Uv5E9
	zIJz4/zZNDWAbXNAMcnk4WSOVKU0XTgYT0L5askgFyMbvXOPjUKL2umTNkA9xoYd
	hQm107Y0/z+T3xnSviM9dbpfvrpQHEIFSoBMaQgtbQ==
X-ME-Sender: <xms:Eqxjajzo1ksWavaqH0xE6QTSQK3DiSZQTNNDS0XiL24gblV5TTOPqw>
    <xme:Eqxjal-iHKGQeyTwhs0enYOMKJXarmZY-DlCFdRUV4tm83zxCOzL8bfvJKtY5EZlo
    45s-zesC08dowoLGYv8Wc4cYROje_A3jBnVdZR5Crx0dabnDMGJxA>
X-ME-Received: <xmr:Eqxjaj8vZnEr41TOtuabmZgZb5V3IQi2dIjm4uIx07gSni4UB_h0G-Ugjsvf45L273t5MSMgVFfP5K-0RCiYeRid-JzFdC-lFNo>
X-ME-Proxy-Cause: dmFkZTGOkEEYiiW47r16VtQ2hKxYPKEAKhVlkC+FNvthZXhDDRcjNhjmp7XUrQmbU4VDl4
    SSWSwRkMnVd0/3/682/Xy2X0FWIbmzubvAQwuYU3V89nrA4htJn0wNeJT+hIox8L4FgwXO
    Vb/KaV5uzL0sdP3//T4L8FNTC6xaVGW+0WW7HesiuhmQzrSDnI2J1T6RdCgE/snx1oqjv9
    ojNt1O7p22yXMxsntisuty1ssF5cbLMAfr/AlbsVnNqqGihdWQydWVANilIBrXlA2PhDR4
    EZalXB4jPaYNfx5h3+SX45ahQNjqOF71r3FjtiL+9Mq1Ygs4Fkd35c0PXdrwIKCuhS+Eiw
    uV75v7D/Ig4ViQt8W5B9xv/RskU1s7dmo2Fu1E8iInGJqPze5m0g3JHkDkCjzZ8clT2rBo
    KSbETkOg9IjODxnRSHfXTDMd6I+GrVXXW0XqmKcfa9mrD7uFvJPx4PcuHcpDSdAcmabIIK
    3aFnUoJBanOMFdN0v9qar6beklNkBNyyfGzE1pg6Yzm7n5xPWin+pwBonHfy/6JATYFK9y
    cDomTIEpI4SQBOZ16/RqkL+jpeUN/y7Yy64a+TL+9ck1SwkQHb+k1avu1ojuyvyQ3v+6BU
    IFHcZHyrVvYwEdV26gN+eHxUYT7T70BIu70h9+qetNgxO4l27ILjMdA1DfNQ
X-ME-Proxy: <xmx:EqxjaodTMeT2VMWMRgEBJQY9tPTGm5JEchGMLiMqnbFuV2JowAO80w>
    <xmx:Eqxjavv5HtcegWzGC8oPsiBtf_Tg38w-JPuH9-HlSn2inMYsW9W9hg>
    <xmx:Eqxjah2JRuxE_c_EbiZ6NgZulKHLhGpqqC-QetEut91dmgqDsLgGEA>
    <xmx:EqxjasAuqyHpXM_V_-wg6jYa1B3aNflp7x-WHRDU-aG8fz5fCNGmtw>
    <xmx:E6xjakVVry3yATmbB4TUvxr3gsSfsxOIzp6inTerW_BOZ5cG14dtvLfE>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 14:16:50 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v3 0/9] Initial Apple M3 Pro, Max and Ultra device trees
Date: Fri, 24 Jul 2026 20:16:40 +0200
Message-Id: <20260724-apple-t603x-initial-devices-v3-0-bbeba0420603@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OQQ7CIBBFr9KwFgODVOvKexgXFEYd09AGKNGY3
 l1aY6Ibly/58948WcRAGNm+erKAmSL1voBaVcxejb8gJ1eYgYBabIXmZhg65KkW6s7JUyLTcVc
 OLUYOiNaAaxxow4phCHim+2I/nt4cx/aGNs3KeXGlmPrwWPJZzrtPqflbypILrnWrhN4pJUEdb
 sZ7M649JjanMnzJ5P+3MxSZO9e6hc1Ob6X4kU3T9ALSTekuJgEAAA==
X-Change-ID: 20260705-apple-t603x-initial-devices-2eeca2d9d25a
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6035; i=j@jannau.net;
 h=from:subject:message-id; bh=OQ7Q9pVZSxs7MTqxhl4F2QNfjfU5ODNpgazXAT5XJYw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzkNbzLdy98VbfdKufEqSCpw4UvHwvdifjY/fhH/bqt/
 Jer/Sed7ZjIwiDGxWAppsiSpP2yg2F1jWJM7YMwmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKb6TBAjQ99a8XsOPxTOStj4BEc4v7ovK954MUj6l9fcN+t0jkzfwM/wP2etjci
 JHyapW7UfFXIKfl87eXeJ5aLq/VNuzV/Kd7C8gxcA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

This series adds device trees for Apple silicon devices with M3 Pro, Max
and Ultra SoCs. The M3 generation has fewer devices than their M1 and M2
predecessors. The only non-laptop device is the M3 Ultra Mac Studio. The
Laptops are the known 14 and 16-inch Macbook Pros now with M3 Pro and
M3 Max SoCs. The M3 Max variant with fewer CPU and GPU cores has
additionally only a 384-bit wide memory bus instead of 512-bit of the
full M3 Max. It has a separate identifier (T6034) and so there are six
laptop device trees.
Another difference to M1 and M2 Pro/Max/Ultra is that the M3 Pro is
distinct SoC design and not a smaller M3 Max. For this reason both M3
Max variants and the M3 Ultra will use "apple,t6030" as compatible
prefix. In the M1 and M2 generations Pro, Max and Ultra SoCs shared
"apple,t6000" / "apple,t6020" as common prefix. There is currently no
known difference but M3 Pro and M3 Max are not as closely related as
previously.

This series adds the same level of hardware as the base M3 (T8122) has
in v7.2-rc1. This includes CPU cores, interrupt controller, power
states, watchdog, serial, pin controller, i2c and the boot framebuffer.
This is intended as base so that support for additional hardware can be
added to all M3 based devices at the same time.

Merge strategy:
Since the dt-binding add new compatible strings without driver changes
it would be preferred if the whole [1] series would be merged through
apple-soc/arm-soc. This will help ensuring a warning free
`make dtbs_check` for followup series with additional M3* hardware
support I hope to send for this cycle.

This series will conflict with the M4 series [3] sent A couple of days
ago. I would prefer if this could be merged first (in order of SoC
release).

[1]: I see that the M4 watchdog change was already picked up by Guenter
     in [2]

Link: https://lore.kernel.org/asahi/a03c19ee-cf74-4f26-826d-f2bfb816fb3f@roeck-us.net/ [2]
Link: https://lore.kernel.org/asahi/20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev/ [3]

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v3:
- dropped the already picked watchdog dt-bindings change
- fix node ordering in t6030.dtsi and t6031-die0.dtsi
- disable power-states for absent memory channels in t6034.dtsi
- drop stray spaces before closing brace of "cpus" node for t6030, t6031 and t6032
- imported Uwe's Acked-by: for the pwm dt-bindings change and Sven's Rb:
  for the devicetree additions
- Link to v2: https://patch.msgid.link/20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net

Changes in v2:
- fix serial0 unit address in t6030.dtsi, drop erroneously added 0
- Fix device node reference in pinctrl_{nub,aop} gpio-ranges in t6030.dtsi
- fix i2c6 unit address in t6031-die0.dtsi
- fix cpu_p25 reg value in t6032.dtsi
- drop unnecessary aic interrupt-controller from t6032.dtsi
- drop "label" from keyboard pwm led node
- fix copy-n-pasted pinctrl in compatible strings in the apple,s5l-fpwm
  dt-binding commit message
- fix yamllint errors in apple.yaml and fix warnings in newly added
  lines
- fix typo in i2c commit message
- whitespace fixes in t6032.dtsi
- add missing Signed-off-by: for pmgr and pmgr-powerstates dt-bindings
  patches
- drop already picked-up "[PATCH 07/11] dt-bindings: pinctrl: apple,pinctrl: ..."
- add Conor's Accked-by: tags
- Link to v1: https://patch.msgid.link/20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net

---
Janne Grunau (9):
      dt-bindings: arm: apple: Add M3 Pro/Max/Ultra devices (T603x)
      dt-bindings: interrupt-controller: apple,aic2: Invert #interrupt-cells condition
      dt-bindings: interrupt-controller: apple,aic2: Add apple,t6031-aic3 compatible
      dt-bindings: arm: apple: apple,pmgr: Add t6030 and t6031 compatibles
      dt-bindings: power: apple,pmgr-pwrstate: Add t6030 and t6031 compatibles
      dt-bindings: i2c: apple,i2c: Add t6030 and t6031 compatibles
      dt-bindings: pwm: apple,s5l-fpwm: Add t6030 and t6031 compatibles
      arm64: dts: apple: Initial T603[124] (M3 Max and Ultra) device trees
      arm64: dts: apple: Initial T6030 (M3 Pro) device trees

 Documentation/devicetree/bindings/arm/apple.yaml   |   37 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    2 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    2 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |   10 +-
 .../bindings/power/apple,pmgr-pwrstate.yaml        |    2 +
 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    2 +
 arch/arm64/boot/dts/apple/Makefile                 |    7 +
 arch/arm64/boot/dts/apple/t6030-j514s.dts          |   22 +
 arch/arm64/boot/dts/apple/t6030-j516s.dts          |   22 +
 arch/arm64/boot/dts/apple/t6030-pmgr.dtsi          | 1437 ++++++++++++
 arch/arm64/boot/dts/apple/t6030.dtsi               |  524 +++++
 arch/arm64/boot/dts/apple/t6031-base.dtsi          |  297 +++
 arch/arm64/boot/dts/apple/t6031-die0.dtsi          |  197 ++
 arch/arm64/boot/dts/apple/t6031-dieX.dtsi          |  107 +
 arch/arm64/boot/dts/apple/t6031-gpio-pins.dtsi     |   53 +
 arch/arm64/boot/dts/apple/t6031-j514c.dts          |   18 +
 arch/arm64/boot/dts/apple/t6031-j516c.dts          |   18 +
 arch/arm64/boot/dts/apple/t6031-pmgr.dtsi          | 2400 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031.dtsi               |   48 +
 arch/arm64/boot/dts/apple/t6032-j575d.dts          |   46 +
 arch/arm64/boot/dts/apple/t6032.dtsi               |  416 ++++
 arch/arm64/boot/dts/apple/t6034-j514m.dts          |   18 +
 arch/arm64/boot/dts/apple/t6034-j516m.dts          |   18 +
 arch/arm64/boot/dts/apple/t6034.dtsi               |   53 +
 arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi     |   66 +
 25 files changed, 5818 insertions(+), 4 deletions(-)
---
base-commit: 9c8070a41716d59f1d4d6ad1428019dcb233fa20
change-id: 20260705-apple-t603x-initial-devices-2eeca2d9d25a

Best regards,
--  
Janne Grunau <j@jannau.net>

