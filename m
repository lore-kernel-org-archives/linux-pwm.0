Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A3361DD3
	for <linux-pwm@vger.kernel.org>; Fri, 23 Jan 2026 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160841; cv=none; b=IL7Ol6KtRoWlj9ls8O50+SxZoq5Lr+Jf+RNO/OkEBFVs2eCwbI6EGInr6Vat+GWoedffE7yh+c4THY6Rt+uvlnHX4AMAz1M+9GA0zrNFQdS3P8e5L7P0nAW4PmYyXgx9TDQdfYK7RkZzuAirvhX+A89+K60NErTkUy/eC4ukTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160841; c=relaxed/simple;
	bh=yPdMZHCd+odB+tMLYC+rVsxO4J1sPgCZ6HLjvUDlrWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMsmIxu3AsvYE68kOo64ghE1v9h/omkhMj8GNPPml29cyL/NUgscHtz/w70jPsO2AntHKuW6XJgB7UtmQPuR8OztWv7kcWDnpDhI9iqu/zDiY+wag5XoPwuyyyMcdvr+iNbBMFxRBgLjMq4Z9SDR+65PH0tWttGaPxrghdhOyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SBj3gjtJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SBj3gjtJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F04481A2B06;
	Fri, 23 Jan 2026 09:33:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C68606070A;
	Fri, 23 Jan 2026 09:33:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 742EF119A879B;
	Fri, 23 Jan 2026 10:33:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769160831; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=6HdXNZ3Nba+GjaEjoZsm3NjZLI9rre4BgbexuF1mMZI=;
	b=SBj3gjtJo/1rgjyDl7/r5f9nceA8TyQzz6LvG0/gA6DDvoG+96GwNz7Kv6prMAItwE0JKX
	WdLOrIQ7+9MDcHUVFxpUPsliWfeMACv6NKH1l6zqyuogefVe2KqXYyePwE+IZs2Q2i3pCh
	YoKw1eecQLU5X5yGwfEiEkDgRcK/inTj36l5jF67Sc2UUGHI5NZ20mQ06GOtLqF1FkI0Pn
	F/yZSP6oQs3oNrjwL5wsfAU0qUSUyM3/FLbcOQ2ADrO34wXMCF451TsyGXF7JOi6KPAmFz
	+gSeJIdNrKn5CPY1hyaMrSIKM2Xnuxyxrqv7DorfreZX3yV/14o8E9rA4Xwlyw==
From: Richard Genoud <richard.genoud@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Paul Kocialkowski <paulk@sys-base.io>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 4/4] MAINTAINERS: Add entry on Allwinner H616 PWM driver
Date: Fri, 23 Jan 2026 10:33:22 +0100
Message-ID: <20260123093322.1327389-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123093322.1327389-1-richard.genoud@bootlin.com>
References: <20260123093322.1327389-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add myself as maintainer of Allwinner H616 PWM driver and device-tree
bindings.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa218..ac7b07f4eddf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -903,6 +903,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
 F:	sound/soc/sunxi/sun50i-dmic.c
 
+ALLWINNER H616 PWM DRIVER
+M:	Richard Genoud <richard.genoud@bootlin.com>
+S:	Maintained
+F:	drivers/pwm/pwm-sun50i-h616.c
+
 ALLWINNER HARDWARE SPINLOCK SUPPORT
 M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
 S:	Maintained
-- 
2.47.3

