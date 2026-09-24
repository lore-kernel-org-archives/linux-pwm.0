Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD049E5DA;
	Thu, 24 Sep 2026 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262913; cv=none; b=gLnpBTKjntwgDu5Jp65uapsDjV48dlYfIIpRd8hvbfFOrqhlx6SODxo0e+S902IRfOiBeBevfCtlPYh88icnsNj/S+u5bhHVLfcImGOw9k1osXHuOFL/MveANMxHqRqa4AACjqQHrAlvPMDWTATcTCUthKEIe65xtGJYuHc4IlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262913; c=relaxed/simple;
	bh=/Xr6Vonrl8KSO7NkZYS+4LuXBsR+pRx2JEkY9vxDmtQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oLziH2V+cESjhApKLcMJyhHuIevdYUxZZ0TattTYlM5Qoum+fOYbg7LiW+4JK8NhSoAuWRVRFmM89yOBE/+kUk/F1RaXnzWEEQOTZyJs4xba1vefw+AR2wOQrE5E8t0REyC7L1FtsGYtrNb9mXDwT72PJsxZQ+i1i1Vlm0vEsR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3wwbQvi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3wwbQvi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D269C2BCB3;
	Thu, 24 Sep 2026 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790262912;
	bh=/Xr6Vonrl8KSO7NkZYS+4LuXBsR+pRx2JEkY9vxDmtQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=U3wwbQvi5AFzyxA4B06J5JsixLbXKaWdSed3f05RSTIBWwTxiheue3U5QuQGQ2CJ6
	 RLKTTCgd59x/qDgFJwa8clt7nwSjD8dx4DGlkE69JY26BWJVII+IsD4ppm72YXOAYz
	 MLO3qnYXM0HrkFy0BgQvRfyPMowNh+kbThk6SwQNkDvoFnPlJHXwI8ByENWDhrd6ao
	 eVBJIBstbhJXZc8QW28RaRpq5EcRvALNJDMzhMiv3mQ0mKn7jhIpSpD1Jz6xUg5Rsd
	 2Jxn39UUZQwOJ8hyI3P79TsEEwg4JxU8tXGFRxhWJvktMTKor1J5CwC7MKFRvUS8xw
	 yg/d91Fytg1mg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D5DC98318;
	Thu, 24 Sep 2026 15:15:12 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Subject: [PATCH 0/3] Add T7 PWM core clock support
Date: Thu, 24 Sep 2026 17:14:27 +0200
Message-Id: <20260924-add-t7-sys-pwm-clk-v1-0-05b91e87f0a9@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSQqAMAxA0atI1gbaIk5XERdqUw2ONOKAeHeLy
 7f4/wEhzyRQRg94Olh4XQJ0HEE3NEtPyDYYjDKpKkyCjbW4Zyi34HbO2E0jOkXO5bolMhpCuHl
 yfP3Tqn7fD3qqaZlkAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=/Xr6Vonrl8KSO7NkZYS+4LuXBsR+pRx2JEkY9vxDmtQ=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9ZWu/Lohq/icVfPylbtOzRvz7nEya2av36tld9SPduif
 dZR7/4HHaUsDGJcDLJiiiz9cy1PvLt89MzXPeopMHNYmUCGMHBxCsBEOo0Y/hfIBllYapSx6uxZ
 JmUx3+bj/kctv2d93eP4v226gpLDns8MfwVDfi86aPRj6kmPOa48m+sZK/dNbwt/t3WTyRdfacO
 LunwA
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
Ronald Claveau (3):
      dt-bindings: pwm: amlogic: Add core clock for T7
      pwm: meson: Add optional core clock for S4 PWM
      arm64: dts: amlogic: t7: Add core clock to PWM controller nodes

 .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 37 +++++++++++++++++++---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        | 28 ++++++++++++----
 drivers/pwm/pwm-meson.c                            |  5 +++
 3 files changed, 59 insertions(+), 11 deletions(-)
---
base-commit: a8c591ed6b672915e0be57843f943a2a723aff40
change-id: 20260924-add-t7-sys-pwm-clk-f0eff81bee21

Best regards,
-- 
Ronald Claveau <linux-kernel-dev@aliel.fr>


