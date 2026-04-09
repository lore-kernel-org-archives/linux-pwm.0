Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B59E40DFD7;
	Thu,  9 Apr 2026 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775695525; cv=none; b=KmaF5IlbTgochu8u8PpjtA0y25IyzS9vy738QkHKKWyGWrmKl4kCeyrduA+MnrtWa0BMFA7+fSITct041QooPSLRpkbZmdWNryNs7olDfsgEe0P1uxm5rtjPn/lgJNo+VNAkyPJL9kD4XT4B3K7FX1jaUiig2VQBPwWX95YwB7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775695525; c=relaxed/simple;
	bh=RrnZjnWzHyFMc/BnaWeEUZwombxgctKzEBN1fyRhhoY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=evFcSeS2LFCUK8G6Ebn9FqGXoCiVe4GKvoujM7SMHJzoFcSUHWyh1hsyKgu42uy7hPMM4W8MXZZB0fyt0xvPQ+rPAVob1lX9is4Qpvyq7T7IOK/gySbq4JAsZHa/eA/4VKkRx0eA3i/9mbjjMuwijR6BbhbGJ3/lECV899M0AII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOgPu6Az; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOgPu6Az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ABEC19421;
	Thu,  9 Apr 2026 00:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775695525;
	bh=RrnZjnWzHyFMc/BnaWeEUZwombxgctKzEBN1fyRhhoY=;
	h=From:Subject:Date:To:Cc:From;
	b=GOgPu6Azr3VKSAfKz47B/Z/fF2S1vrevG3TT13BtsqX/RwR7XixYWl/T/gMrAN2IK
	 fODuM+DfU/1LEbHfd2WKQrt/kWak9X6YTeZis76Um83YV1QfjFAh02xPQSVUBkv0Lk
	 pl9Lvtambjr1D8fk6VEwVFtTlnLjHIWz1Q4Kc4dYQDakr8VtNnTM4MaVFdhaBB/eV8
	 HlCoT/TsmheBdp0Ju3Tv3yFOxiGvhz4B8wRaHZqoeVmT81VchcMV2OHoXc//tlcaTF
	 NEaKEQj0tFgvTFLZG9pZQ5gmLV/pQLrTA98N2KsHPx6z/dJ5eeXE2s06aV7uNQ5uJF
	 3oB+jj6BSq4IA==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH 0/2] pwm: spacemit: Add Support for K3 SoC
Date: Thu, 09 Apr 2026 00:45:10 +0000
Message-Id: <20260409-03-k3-pwm-drv-v1-0-1307a06fba38@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJb21mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNDXQNj3Wxj3YLyXN2UojJdk9RES8vEVGNT0xQzJaCegqLUtMwKsHn
 RsbW1AD/Np2dfAAAA
X-Change-ID: 20260401-03-k3-pwm-drv-4ea99ae355d6
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=762; i=dlan@kernel.org;
 h=from:subject:message-id; bh=RrnZjnWzHyFMc/BnaWeEUZwombxgctKzEBN1fyRhhoY=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBp1vaY1PS75n1C7aaWKjI8sKLtxZ3pANVaRYbje
 fo6dGJMoW+JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCadb2mBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1hmg/+LfIMahJsYd0rprXF78Qi2pvA6gD0D9FEsJONoNUeQDHgOHlSTRJCK
 S8oLzRtiNGEyVjc0b5xH+O12ZDfBZax2ybodsZcvoh+R5NXPKIM3h6lswl/V5F764LMgQqSOF7H
 j0gZtXGlvXj9OUCaaYxNn+5jfhvKBFQ4cbrtBhceo/TOY2GGV8EMVC6yk3YqHySLmde8tIQHoAG
 dsXY5v00BuVMIOHBZMpGYPbjyJ60QU5PVJDkL+Mc3uUCl3ju7QDe6MyusBBJHqCho6G3+LHQPg0
 HHP7INdGaoyqt+Yc6ip1JQYWPvIdp5yas6iEqAwRqwHrZuqoJ4/JsODSy7mwrKftZIb8VqT8lAe
 IZ+xawqzsGHUDtHTikdWIZyqH28yb6QdTQJmf0uYptTgXyLzOE1A6SPkWkkvTXfEHdjaTDlDEWD
 o8uGj7PMJKu/G4wB/8vBReEcifpdHs52dRYk1gR/r0JpdnVugZ3jMXL3ydZbkpeA96Fjs8OpIno
 FAMZ3xpfLnp54JegO2MFn0EOOa+gdclyE8mYg4k7ZaRAyzLVIyqVpaWaa153xl8lV5v0HvO8j4u
 XkJiLPZVSJqhFipW+eITWREtRWfIhQ/fx/DdREb4c7GtrAgCc+sJLHXLHP8uDhhf8JY6KJNwLhV
 S5rJ8qWXhqyYskePkz5dty+MWIHkx8=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

The PWM controller in SpacemiT K3 SoC reuse the same IP as previous K1
generation, while the difference is that one additional bus clock is
added. Introduce a new compatible string and also adjust driver code to
support it.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Yixun Lan (2):
      dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K3 PWM support
      pwm: pxa: Add optional bus clock

 .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   | 53 ++++++++++++++++++++--
 drivers/pwm/pwm-pxa.c                              |  8 +++-
 2 files changed, 57 insertions(+), 4 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260401-03-k3-pwm-drv-4ea99ae355d6

Best regards,
-- 
Yixun Lan <dlan@kernel.org>

