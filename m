Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767149;
	b=WTD+w31OVa/1ueCl882t7ilLhbxOHniRrZBHd64yuSwVYPc1M6ks4LETdOGDceu+62kw
	 o4xmIJm5gH2WMc03zb2RCZORXcC/tHjR0CBztAV9+8d1K//QWJ0/nIdFNyHZEYMl7Xl7C
	 HHxyCDXOgby9wcgaOWXBCiu/mpC8xwF7TWdFKwp/7udtOXtWFrGu6RjuBekMpCx3jjxl/
	 8oiuMPYWHQT5FCU2A9rMvxeHwPbIjaeeF/QcjbWWU8E51bgPCoTFUFSEB40xP/EsCTW5p
	 xrMwb3XUWuK7bJFLsgwuw3r6lFaMdZQcE4v+Ws/AwbgAKlimUmFDFX5jot7WZkPmDcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=biKE31krqx4uiyZbINCmYdssPjN7FXeM4VWJQldNBE4=;
	b=rCdgCchs1EZrG/cvtOe62TKCbXJeq0wL1lQ1WDWv4TcX0UVg8aeKaYkZ/phAVZkLWEmg
	 9hWPZTnVjXZ72ISDlqGKOknlDZFF9nSnEBxLaUHqpQv6lrNC3PxokaX8CnmoxbUhyS9Lp
	 2u8M0kP5I+xd/ynKmH+8N5xfxUyVnw6Z9lHtMZ8w8luQ/NPBicuQ4dng9iu45UDtJEeb6
	 W/beFmVrhFD2VDKpbuYz5mclyLogkaO9aqkqS0uDnV0QsugR37f+GFI4Z21POGeA4lBQw
	 6iIHgOpfwCSDfpReyJ4tECWz1vqqNasHFoFgPSoTrqASEABSEdAuH/jbCQyh/ofG+nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N89OvIaB;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D4B606A32F
	for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 08:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81D4B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N89OvIaB
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2761c69fbso11055582c88.0
        for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 00:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795767149; x=1796371949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=biKE31krqx4uiyZbINCmYdssPjN7FXeM4VWJQldNBE4=;
        b=N89OvIaBZgxgs0mGBtRsN1D6wvlneHG+Ksgqf8QBWV8Et0c1ehC2N6EdeuMO2OygiD
         GazawBwIBvjOvwQx0T19XiNyPssK9vbrCGCjCpelG4SjFmy++YSnow5jX3dG0NDCjj23
         4UDs113EzwugS+U12RnTr5+4XA6VfYzdBcScg48dyIIqREon417fNLXMmAmbng4Rku8s
         lFeZ9dsa20oW95nrB2N2mDuHDsMwbAqBvdcLlWoHYJ04FVO176aw2VH8k+4kUcS6m6FS
         j20Cc6GMtm7ePkyCMbEl+ZmSdfsvP/vn9sLQs9RCjuL8Uj7l6+rooFBWYlWR6O69+5MR
         gYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795767149; x=1796371949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=biKE31krqx4uiyZbINCmYdssPjN7FXeM4VWJQldNBE4=;
        b=0261f2EJ/TYT/6ig6BxNlWwWl2uKa/JM6GtqC8dK/q7qL+GK1ekByAJwiD2Ubu11oL
         QzVz5L+wcvjJbc2q5cfTnw0kwQapTscHhsNZEhPDhakjvQtdHjPNdEP22IZECeW7vxcK
         QTQbutIAhk+Kc4/Gqnxvkgby46My0J7T51QZAVtSC6uONZfQz7BU1aXjkFsYCG0rEIc/
         bKRrxgh8FnjhKVZyp8OaWr/hs3JgwEMZqxdYNaap710LZ03h1GQ7GMIbtxZNnTqrqThx
         UrdQ8gyCvOfA+2LiiWkR6njyoJkXLaXFzNfydsXPxGpkuKb1I01l7AuqSvP0H5/7AhrI
         pBkg==
X-Gm-Message-State: APuU4Z927+wih2vd3Nrq0GTRJsq5vj2/tfTrcAHNXqoMGdtJ0CnQum68
	EP8cEPS1UPFx1qoydYDAeAZrLtWZWQsR3jW4J7llrduVZ4JigCmvb9We
X-Gm-Gg: AZFdTZc3QPPZv48HLqq6oEN584IWBW2T3n1j8YwjOFZeDN6zXJ5UaS5xMbJKbsJS+Sb
	XZU0l2l/9A6s9zwd3SbzQ2jM2fU1EBFPScclQv+BjJgFz5Wb0rMKpMqypaP/kyHzJfGdqqrQ//u
	QI1OTw2J0ADye7ZJzsilXKxiBrmFbOswvoZ6GhtEMj8QCqAgbBOkbWiAw8f4iWSZckORCSZ2yds
	STZJFrUVfNLvrdb8TzK9eYtRKItI6gxT4xJk7ctEghA/bQPW1J6CLKmKUrR64dln4Vpt4siQY9s
	GiomdmJZFXQZX+sGOHvlvRHrJE+rXNtL3rFIAe6qJ/Su8AEDV1RhOPpefMQzRL+qM4oiOeApGHX
	AnehLEj9yZhHI9SjgqlYaloPqWjfmmsZB/ObMCmfKt/a1PnkCW1PZs568q2kMXr/Bx2kqt9oSsL
	NhbxsC+fgoocywFvih1eLtzPPHcYUtd/roDAZw7A4fCr9bZU8CiaW0QLW3VbQYKnP4e3whtkZsA
	SxwUyz21eThBy690Q7t4L0KV0pB48oVT8y0+YEgwuwN7Eot5kXx3M8nMnIPU6jSdQkBliDle9xX
	r12V13DusqhQ5qN4cmHrFA8WR8en6B7gjunDOr+9Sc5pDmQ=
X-Received: by 2002:a05:7300:2209:b0:386:8d2:929b with SMTP id 5a478bee46e88-38608d2945emr34239903eec.23.1795767148650;
        Fri, 27 Nov 2026 00:12:28 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm41286650eec.18.2026.11.27.00.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:12:28 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pwm: sti: request the IRQ after the driver data is initialised
Date: Fri, 27 Nov 2026 15:12:20 +0700
Message-Id: <20261127081220.302726-2-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261127081220.302726-1-congnt264@gmail.com>
References: <20261127081220.302726-1-congnt264@gmail.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sti_pwm_probe() requests the interrupt right after mapping the registers,
but sti_pwm_interrupt() reads pc->pwm_cpt_int_stat and uses pc->dev and
pc->ddata. Those are set up later in probe, and the clocks that the
register access needs are also enabled later. If the interrupt fires once
it is requested, the handler can run before any of that is ready and
dereference a NULL pwm_cpt_int_stat.

Request the interrupt after the driver data and the clocks are set up, just
before the PWM chip is added.

Fixes: 25eb53809674 ("pwm: sti: Add support for PWM capture interrupts")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/pwm/pwm-sti.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index bdbb61e44fe8..73b8690d596c 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -568,11 +568,6 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(&pdev->dev, irq, sti_pwm_interrupt, 0,
-			       pdev->name, pc);
-	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret, "Failed to request IRQ\n");
-
 	/*
 	 * Setup PWM data with default values: some values could be replaced
 	 * with specific ones provided from Device Tree.
@@ -614,6 +609,10 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = devm_request_irq(dev, irq, sti_pwm_interrupt, 0, pdev->name, pc);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
+
 	chip->ops = &sti_pwm_ops;
 
 	ret = devm_pwmchip_add(dev, chip);
-- 
2.25.1

