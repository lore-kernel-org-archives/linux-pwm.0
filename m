Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767147;
	b=kNqNka/edmcxBwszJ8JCRio5oQAidaiUm80dSHSVR3bYL1Kvc1YgrKtUia9xOhiUJbkb
	 NqYqF0uKc/OMNUy3Vk70h6ByaGd/4sl8xpa5WIRlgChf5jvKswG2lAw3Xw2/E00y9Lv2y
	 BbZLmPVujS0drqJzh55vcc7I3Wi80soEzM+Yi1gWOGQwBA/YmPZdxZwn2jZP9C5uU9CVY
	 //dxE2AmDZBxzfFxvrBydHmPx/2QGBB+mHKPLqt8QiR2pmL7eDVN8IkBWW2cedtX5B4lb
	 GAFUjnAtcjhVWCcNIpwn6zVNZyILCvrXZjoqDwr5ZBjeCHextyylf/nTpY3ZDZT1UtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2pJydPrYzkvGACVJUI4Nizye21FZq+7Adb+v9+G0Kq4=;
	b=Fmb4410CzaTArCoqJ6+YBK0NoGtu3X1b8XsGmGr37GnB/J3IR8R0ZGPSxKiP2voP08wn
	 O50+Uc9i4XFyACT5/Fm+BSpLQqA0zhIBMpiVQQ4cFCbqMMrG0pO6he/kFjPN90hgxPUxz
	 mmyOehQ7awdi2lpmP6v5vXlL7cLJQRCnER4WvOTh6aJKMrF0TEkEKAS54GUc477Xy3lfV
	 lcF0ejwVWZIDfam6KTAFNb45XajN4JZ2k/TRcIWGVzair/e4Y1f2o7W0H2I7zG+B6D0rC
	 wn1yUQIKPFfViBvhYBZ8lORbJpHqxXFXYJkb8fpLlSiP/ahol3pjivgUqS+96kI3Hvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=psoc+VjX;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E70606A31C
	for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 08:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66E70606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=psoc+VjX
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso5744659eec.0
        for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2026 00:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795767146; x=1796371946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2pJydPrYzkvGACVJUI4Nizye21FZq+7Adb+v9+G0Kq4=;
        b=psoc+VjXdpRY5YGsRXLFyelfDX+lPLckHOWsO6pdqZajXjXpjfpXB8+6PMWF6Oj17m
         s6IU0TasDCVr6qEXxnC9LAkbizksCSVfv7hZMYGpVKZlFNPHrldbtX2Uaq9Yrx/poMTy
         Xy7OieGUCWuicI+Ho6rugDyWmcv/tZ9M+EzFPqr7tZjY4SaIB2u7Jmo5rdS1Xn3HX8JG
         gEXTU6Lp8+N7Aqej8XPxnqN4tq95M1/6PTmw0F4BjpTMg14noOz81FvILBH+H3PhQl4F
         4uW55KHKNpmGkJu33a+Tl4AE2ocB5vEl2MbUTdhxnJ0PqP1MRYKgz1pDqKh3lfJ13Qal
         Am7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795767146; x=1796371946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2pJydPrYzkvGACVJUI4Nizye21FZq+7Adb+v9+G0Kq4=;
        b=z1/FDGBXap69x5s8CJ8VpM5ts6AB9JdyUbtv8YXi7hfMuhj9BpzSqIZLBv98Hi1rXN
         /pcBLOcHErdK1vYoxzlTy9x9iUyTVuQKPKim77GvgU42BCK5hdP33vnOCWa2XRdCSM0k
         aaWL/ZcSoDXSjzOPxaGvvePwzoBSVg4pmk7IqgqDKYzLSXdEC1DC7TFPC3t7jSY0/62Y
         X1kXr+k+/NaAoGqM6pLw3QSxnkcQ3Rajv5qddUE8YLl3D6nX2lFnL3cwaxZ8opLUs6dp
         86/YbGb+ouNyBQzOjNfCjMGRCoiR9HMb+RXt8F8Kj3QUjR8UAFV0eelbofJPz8HBVZbY
         iEzQ==
X-Gm-Message-State: APuU4Z8fZ9/4uAstqr9FxnF5KGdveg9Vb00MXS6cll5glQk7pCmyfRPQ
	BvQZAqb61716H3qNh7fm0qsSAf6d/tSOUP+FgddPHr+Zde90Mfic+jaC
X-Gm-Gg: AZFdTZfTr2Sn/SO59GZefbXeALUavGFb1d5Xn8jCoj1fDwvBOB2m/yMUeSR0UjiEfoq
	UJW2icRj9n3U4VPHzdoHHJQyCdeExdexLEv1i2xmJm0cLW8BvOJCM6VzT7CT9wA/whGoc6bW9Og
	lGCKO03vOmHXwdeCiMTWGs7lbKdouuGOj92HNN+pkem7Z35OB1yJ2wne2TRUlHQypg07+SFeD//
	oMRx3N9vCz4oA1t+gqdl5r7xjsPssbYxMV1JkRk4Ul47lvcPtIK1qUWJ2Ysp4AJEzyI9nDI//C3
	CqDcU3pKa0NYPtP/3ucI6mMu9hWMS7E4Rvb1k1VtdqdpBBxJME8IBE3ASmLBcVgXXSTMRw8d6+P
	mlZGsQnFXBXOsTyxo4U+24krKs3bQ2bxmSS1gibxMV0VfnJ6c6uPo6RTGzygrCQW+9j1Qfq8tKO
	v16YoSVjkGQz2VBsd8gxDOKxlxFu4RGHBf6NOphsue0AU76pdFOeBGHxnRWE2/uPNmDNMdu6rEQ
	8wPuJgLtNO7bq2khl2lEGg/XEd0bCRVsKNbvwyYfxJjodIsC1pdEFOsl4UUryhAOZ7Fu0HK/NGv
	9omVxoBM5mGqv6AqWM8NUdosfTm01rzI/jrV2ilxmBKgWI83
X-Received: by 2002:a05:7300:6da7:b0:384:5885:2f81 with SMTP id 5a478bee46e88-3856c0c7c06mr8085826eec.5.1795767146462;
        Fri, 27 Nov 2026 00:12:26 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm41286650eec.18.2026.11.27.00.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:12:26 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pwm: sti: return the error when requesting the IRQ fails
Date: Fri, 27 Nov 2026 15:12:19 +0700
Message-Id: <20261127081220.302726-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
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

sti_pwm_probe() calls dev_err_probe() when devm_request_irq() fails but
does not return its result, so probe continues and registers the PWM chip
without the capture interrupt handler. An -EPROBE_DEFER from the request
is also lost.

Return the error, as the code did before it was converted to
dev_err_probe().

Fixes: 3025c9c669ba ("pwm: sti: Improve error reporting using dev_err_probe()")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
If continuing without the capture interrupt was intended, please
ignore this patch.

 drivers/pwm/pwm-sti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index c1beacb26b4d..bdbb61e44fe8 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -571,7 +571,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq, sti_pwm_interrupt, 0,
 			       pdev->name, pc);
 	if (ret < 0)
-		dev_err_probe(&pdev->dev, ret, "Failed to request IRQ\n");
+		return dev_err_probe(&pdev->dev, ret, "Failed to request IRQ\n");
 
 	/*
 	 * Setup PWM data with default values: some values could be replaced
-- 
2.25.1

