Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5641736F;
	Fri,  3 Jul 2026 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092164; cv=none; b=B9poMBVx4FEw3o5HSrA8yTAHStve5FT/NzJHm/FJUEER8BoijPtjxZtTGN3CJzXWdywD1Z3gJsmYuWXgCgR+YBr8HUgHYX3UVPBBMid5DQL6xSu/t9N7gI9YpgXKCJvwJsIq4LTO9pKHVWQCQhkO7XZxRum94ixHYKbZR3iHqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092164; c=relaxed/simple;
	bh=MRk7T34qq7Mf7d7vlIOGFMY9Y3mCwOhsyhmn2szKuNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1F9UMEnYZ7FbhkDlwIaF7MS5maqzNSgUz1ehhlxoA94GlIHJdy7Wx8YFPgFjgkzIiB+m4LpM6OH4QUfIJ0yvQICDj9lvtoZhVOsK+WMyCHDdmntlaW/cfM69GasmAkyJN8MQdMixr5O375CrAWWSoUrxo6/NKIOLWwdTccNFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tEU7CuTo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tEU7CuTo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D153F4E40C70;
	Fri,  3 Jul 2026 15:22:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A645760300;
	Fri,  3 Jul 2026 15:22:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14CC5104C952E;
	Fri,  3 Jul 2026 17:22:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783092160; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qIVGJcDfvA5ZwpQKNPuEjeP78VvaCq6n4AxhxUcG/F8=;
	b=tEU7CuTohFUte7Uxofd/BDZ3rp9SvjYA1AV43V/vdIK0AI6NUgHSOdIGWTcXPE8hHkWCJ2
	piOyMPm2BEpZOFvoVk8A1cdRW2cv8kGUqRhLmvkCMeNzeq71CGfvrHgDVwGCdSaAqs1uyK
	ycQ8m5CFW2e8y+gwsrmzgijSmhAAjqGn19zxXzCNopcsy6oMxvWin2A/yXFwFrV43frexP
	1AIE4WAsUZw5fqAIcELgWUa+lNYCueOGCViHPyD1aBU357XO4oa6BD9yhAVN5caKeicIeS
	31km40s2sgu47abjUfUz+Y9RbJTAGrOLMAlDiVsru8ftZFVRuTQiLTAS8bb3fg==
From: Richard Genoud <richard.genoud@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>
Cc: Paul Kocialkowski <paulk@sys-base.io>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	John Stultz <jstultz@google.com>,
	Joao Schim <joao@schimsalabim.eu>,
	bigunclemax@gmail.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v7 4/4] MAINTAINERS: Add entry on Allwinner sun8i/H616 PWM driver
Date: Fri,  3 Jul 2026 17:22:15 +0200
Message-ID: <20260703152215.192859-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703152215.192859-1-richard.genoud@bootlin.com>
References: <20260703152215.192859-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add myself as maintainer of Allwinner SUN8I PWM driver.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..51ca159bcaf1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -919,6 +919,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
 F:	drivers/hwspinlock/sun6i_hwspinlock.c
 
+ALLWINNER SUN8I PWM DRIVER
+M:	Richard Genoud <richard.genoud@bootlin.com>
+S:	Maintained
+F:	drivers/pwm/pwm-sun8i.c
+
 ALLWINNER THERMAL DRIVER
 M:	Vasily Khoruzhick <anarsoul@gmail.com>
 M:	Yangtao Li <tiny.windzz@gmail.com>
-- 
2.47.3

