Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E71F30A4
	for <linux-pwm@vger.kernel.org>; Thu, 16 Apr 2026 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345307; cv=none; b=jX1J0zZQbZH6qVS437N9eACCm7VUv3WasiYX3FB6VT3nXuIk9N6tV8Cphlxxs8PZory1AZ82aRG0ui0i/DTJAeWIXD2VTuNAzgkkXZA8O++A6UfaGmlDBwNmGvfMayxAi/MudnGhNuXPTI94+SjY+S94isaP/B4vd7qnQFT9aXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345307; c=relaxed/simple;
	bh=V8vXVI39jbgE3XwUq/AMERATPzDdNIVT8/Z0Z76Yxdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvzerQPeGKvSo3KvX9p7PSUhWJc6jUDSv29EAUDxyXMGOyirX03uBmDWck4gouc7SWn68aeMVQ1pADWCZnkZvWSBSOqjIkulJmcwp8+uvLwaoS3V6M/W+Bg5DJk2Q5RHs562DMJZvZ5yPkm2PAtTuUU63Xg62d63j4wZ4pxwzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i9PnDBwk; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i9PnDBwk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 469044E42A20;
	Thu, 16 Apr 2026 13:15:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1C9D160495;
	Thu, 16 Apr 2026 13:15:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 820831045A15E;
	Thu, 16 Apr 2026 15:15:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776345304; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=UCEvI2uNjvS5TOYemxXn6zhsX3CoLIJu6y9+89JVl2s=;
	b=i9PnDBwkTxccX0digZkNPq+phiIy3QjOCKV5WcIR1sDhb+Pz6yeS7K3xGtHZeo0pss0rvO
	hIV9UEOVK82YH4OOrMMxNEdXNHYbT2aOS912yAvL2SErQ//uK8WrhuWimdK6xEqLM3mBy0
	2HXAgRXrjHA4t+qvFLUD8W4PTDsoOgN+PboZOdsklAMOOxl4Byg0xoIrXvTzmVZU9Y08tM
	M1cRV4tU0xofI8aDHQEoc9vqeIzNmn8Z/we6i8u1mUvd5xN31ecuQVx6jMk3echqH5xaG7
	VE20Q1pXGHL8cMKix6LQmHe3NSZPYunaYno//GjkpTQR6stNGpqhk22ej753pw==
From: Richard Genoud <richard.genoud@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
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
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v5 4/4] MAINTAINERS: Add entry on Allwinner sun8i/H616 PWM driver
Date: Thu, 16 Apr 2026 15:14:19 +0200
Message-ID: <20260416131419.3152419-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260416131419.3152419-1-richard.genoud@bootlin.com>
References: <20260416131419.3152419-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add myself as maintainer of Allwinner SUN8I PWM driver.

Tested-by: John Stultz <jstultz@google.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

maintainer
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..256ab8be19f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -912,6 +912,11 @@ S:	Maintained
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
