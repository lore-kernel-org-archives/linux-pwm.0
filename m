Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C4632AAB5;
	Thu, 21 May 2026 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352028; cv=none; b=TrRdSlQpa451P2TTwaXyyGzI2MMOO3BCVvlOJd6CvfkEItucN803nNdV5sLSh1TtbrN11y1s0SqW9dgooUSOq8LhIwOYXZhdjlZqvKts5vROoAsuTSyqe2AgDVV5CihvYUqE/V2MBdzkVjsoK15jYOXpOFoo18X3s3kzH9xJp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352028; c=relaxed/simple;
	bh=bzdk7Kr97M8ZTKkR73nEt8S7smKlwLk3jyxCaislBCE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NIV+y5cBAus/EVnF9AoZUrsR52hiok4KDdYY/5WM+oJtgmn6iv60oNuQi+N/fLVoeEUCchzCOR0Bw4oNACjiF8guYcnyFlbCnU5yFA7ndRkfNawb4D6V9H5tObBcDc7ApyB3FExCUR+7dzdlnJtXFkFTUAmqykQw899fC+WzmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDf6J9CW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDf6J9CW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC2C5C2BCB4;
	Thu, 21 May 2026 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779352027;
	bh=bzdk7Kr97M8ZTKkR73nEt8S7smKlwLk3jyxCaislBCE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gDf6J9CWA0Jkj+sVyKVjYft0qdrfcuAu3LQz1WoiH+hv0NLkaIZ2ATVwNpmU97ioz
	 0ykkbd4X4S1LvMXMliPzlR/X14Zr+i6PJcnG1/whPEFaw/e7mxFfdo4gwiCupEfN3H
	 NIHycvMdX6bfrvnknGywZ4OAKDyLRPJ/+i+oztVtQluhAa+A9miJsj+qLzpcehTaze
	 8kIxP6UET+zM7aP/LRUPtTGoFKsSwNFdn0l/T1JWvSXjMTu6ozAJjX27+78IQjT/8s
	 W1hIfRQLsjgSn05fJd+BZ8GWrh9i6Y3rbnSW+X1mAvCseKQcUt1V3X3FyFhrd32JT+
	 BBX/2nkVR32mg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE88CD5BAC;
	Thu, 21 May 2026 08:27:07 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v3 0/2] Add PWM support Amlogic S7 S7D S6
Date: Thu, 21 May 2026 08:26:57 +0000
Message-Id: <20260521-s6-s7-pwm-v3-0-57b073fbafef@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANHBDmoC/1WMzQ6CMBAGX4X07Jqy2B88+R7GA5QCmwglrakaw
 rtbSIx4nN1vZmbBerKBnbOZeRspkBsTFIeMmb4aOwvUJGbIUfICBQQJQcH0HAB1LoWutVaFZGk
 /edvSa2tdb4l7Cg/n31s65uv1W5G7SsyBg1QWW4V1qWtzqYa768gcjRvY2on4c08c9y6urlCNs
 elTCvnvLsvyARIbnMHgAAAA
X-Change-ID: 20260325-s6-s7-pwm-281658b88736
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Junyi Zhao <junyi.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779352023; l=1053;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=bzdk7Kr97M8ZTKkR73nEt8S7smKlwLk3jyxCaislBCE=;
 b=fQiZzM/Lh8PPnpiLD5LGzPb/OkLEGlqImpKBfEDcs3FUg3JubOsnLumaApJU5vjcr4iZI7XYT
 stuhJIZ/1xGCaD7/XckedZzIBGzrxZzihsUTqgTQOjCd/oOqTvvpAOr
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add bindings and driver support Amlogic S7/S7D/S6 SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v3:
- Use npwm instead of single_pwm in priv_data and format adjustments.
- Link to v2: https://lore.kernel.org/r/20260402-s6-s7-pwm-v2-0-657dce040956@amlogic.com

Changes in v2:
- Simpler s7 clock desc, and drop the example in bindings.
- Make minor changes to probe based on Martin's suggestion.
- Link to v1: https://lore.kernel.org/r/20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com

---
Junyi Zhao (1):
      dt-bindings: pwm: amlogic: Add new bindings for S6 S7 S7D

Xianwei Zhao (1):
      pwm: meson: Add support for Amlogic S7

 .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 19 ++++++++++
 drivers/pwm/pwm-meson.c                            | 41 ++++++++++++++++++++--
 2 files changed, 57 insertions(+), 3 deletions(-)
---
base-commit: b1385d0c7b7c633e55adcf4a7c1ef46c43a84a4a
change-id: 20260325-s6-s7-pwm-281658b88736

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


