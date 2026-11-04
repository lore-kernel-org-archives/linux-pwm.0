Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820312;
	b=dIymI/caRp0zzhAb6Sz4Ctory0rTWi0IYf62QUYOKFfphkqovnuVR/wMbmBMA6W0AOqz
	 QsBXTXY7eeI+y+MzL/NR0vBGs+UMjbDGx9Sd4ZBpWSDdsqx8+iy5nlPgew9RCcMOcozIz
	 yPgf8X0j/RmuusnW86/63cov2AelDhHxMLNPhXP+e0SGVy1QFhLhuUb/7xYJlH7NEq2F/
	 Ncom9lALJCxqa2GR6kC7UNmuagGASlmT3LhuYydzJCuq3sxvJYJ4Nu2snDjKcTy5R8kna
	 t9ieM1fothSry8nuKTMRE0H2q7kVFIRb9vaqGZovH8Yi0nuGG0L/xGDanN4rJ0zNAjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=JUJOd9ewD2XzFuoXefvfL/kztf8QXUFxcaNj03ZJSj4=;
	b=qaHFZlT+uYdfXLiKIPmKFIDzIOjjVXZg0IUBNQG3lJCNw1xPKwxTpE6ISdhRaEaUyUBL
	 X423b5BDs5HWaxWoS8jF4Wc9robafvMX0EjR5pE9W+GPk3kRDtUYpv2J8Rq48Ys9smqm4
	 DEZKnOErC1d+71CqTtvwvXiKiP/RC1ydlkk3rTBMaa6gany3nwfqoVtpToT+MMW5B5bvk
	 9Uygwx38fxKPN5IJa+CAvPoqHkFMlzxGNF67vW6sonNVyS84WFZnoHGVlWZdAujGEE7sO
	 Jj+Sz1uRBDFmc29Qnokhe5uMav4peUJp48Qbt9qiCXKZ9EeV4fYdmWQqIVo6iB0DLZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l+q59A3+;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB676080788
	for <linux-pwm@vger.kernel.org>; Wed,  4 Nov 2026 19:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AB676080788
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l+q59A3+
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-53ec2cc397aso580177b6e.1
        for <linux-pwm@vger.kernel.org>; Wed, 04 Nov 2026 11:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793820310; x=1794425110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JUJOd9ewD2XzFuoXefvfL/kztf8QXUFxcaNj03ZJSj4=;
        b=l+q59A3+sOw7fKxiBQJb7McYT//0hRwvDg8Ct786G6Oy50j9vWzWGmZnEV7RHgdMWu
         98SHuZlY9XUQYHhg0iDB8rrqf6CjaScx0qFGzrVUN0aP6NK7YhnwwT8RGc6I0YOYPmz7
         /ijtTs/dmM4lZMndW+0EfVVvzaPyJMvxKkrZiE0N3yRt0lC8+mNAMspdIwrbCvG3R3LB
         un2KOxhfWDqnY13nwSBSSUqN83H1QoAUhTwyPLwvH7CEdDYly3uur2iMlYthKDNftoGF
         TErHkRGKcn0k6N6C6MwT6/0kSLXFRwfiMjdkjOMZkhK4PV+aHmUuewZwVzCuNNZ7bz8d
         1Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820310; x=1794425110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JUJOd9ewD2XzFuoXefvfL/kztf8QXUFxcaNj03ZJSj4=;
        b=XukZXDGoBUUGzuUGGvhSRaoy4TIyr4eHUTaJFw6hs2KKuCPv9T83+TYOYbTRY9KkMR
         rjeLgzPt3GocEXM9SQcYd/F1gjqWqZ08BlWp3nwLn5FyzTxWTT1u93nTZyAjXcpwOYw0
         Jpg8diCNzMnf3q1XtGcay1PNw6X99gotEsn5v1xDMUkIKaBlfWP9XhOb0hNOFIO32wCP
         pzZ2RNcWcUQ7z34CJc+3MEr0zXHOGOsRYCnp7v1eJwt0xxtvxfObEvrqSPzopomZnh1J
         T8m8hbN3i2kUtQk4RcshHpwskdhauOG+2MYKb3FZngE2axAG6ocKwFUgglgJOS3fgygR
         8AZg==
X-Forwarded-Encrypted: i=1; AKwUvBwBtdR32JljoEA8rr+wL63vddhgznAVuTMrndKwwjsVdDgzV5+Q4OKEPHxtpFZjOuMtAi8+VuDhRSI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/50DzCBAxZ/BiBet2wqx528+CxLKNpeo5E9jerExS7b28cxApc
	uQcR2OhPmVEoatmMU1fL4Kg1DIAubGX4B6TpkkdshUcNoiQWhR2USwUk
X-Gm-Gg: AYBFou05ChoSCqy1KftoUpLK9CEjtoGhS9BlteYsBr3Rwi+pw49EeDwYLJR9JHuS3dv
	SRT2OKktFbPRTrVF36QXw89PJ8A4YZ6SPEfMrPyfcKRMlQifWFSkCJb6XNIAzm30IPJUQ41K4nK
	Or7qSywt0p/Q8Suj8+3M6GnDQIcu3MQtNVKWEiwvH0g09xmcPucf4mHcf2+1BNDgTBBZTM+ULr0
	XcOSQPOUm5Zk61ISsY3RlhzwvevvUJxSjJUIEWACUtWWE+fn7A7Z6YYZRjXgO3rdRkRBE092K6s
	vzfctjeTC5R2K7bksvpRu1DRxQh0BvZyDI61oqz1fdeRHQpn1D3nOhpSoNCBy8lmN783R2yknl1
	sGx/tk9d18D1giI/cBtRM2j110i1/7dXa3VvA/CmL/kQ4pSRsjhK+FnUb7dHHYQecLs8bmX6XoS
	m/iU5YMQdi8cQ6Vkj4y3d6sBEh3RgA8sr2ViK7xZ2lmjQKW9aLHW4+7cbbEp+WOG6gQRI/A/4CK
	F3VrW5fRPM7qXhcj5lIvGm+MHRmuzaHUq1EjqUTruWuZxpGrSX+fLEymLjo0LhK5K2abWIwUyQW
	ywtLB0cKZB3Ds7HlZxELKhUrimsK36+2g2+V5W13pV9rBC5RnNa4Ra5ZPQ99T9E1UU1ywAgn+iN
	PoRLh0VBotugn0cmc4A/CEyTbIxdYZ3RsWLJ7WYMxaFmmL/AoBH9v+fDKHaWESAjmWdpSK1uzBQ
	IKpiqXHtLQsVlCVdgmNm5uO+0o4SdBG6Kr2DlrROLkAf1rEW1D52w4
X-Received: by 2002:a05:6808:198e:b0:4d6:9293:9b56 with SMTP id 5614622812f47-5640de2e892mr13003756b6e.62.1793820310505;
        Wed, 04 Nov 2026 11:25:10 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9c7bbcesm2328723b6e.1.2026.11.04.11.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:25:10 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 04 Nov 2026 12:24:55 -0700
Subject: [PATCH v12 5/5] MAINTAINERS: Add entry on Allwinner sun8i/H616 PWM
 driver
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-h616-pwm-v8-v12-5-8ed39b0dba69@gmail.com>
References: <20261104-h616-pwm-v8-v12-0-8ed39b0dba69@gmail.com>
In-Reply-To: <20261104-h616-pwm-v8-v12-0-8ed39b0dba69@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, 
 bigunclemax@gmail.com, linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

From: Richard Genoud <richard.genoud@bootlin.com>

Add myself as maintainer of Allwinner SUN8I PWM driver.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..b80ae0ac5eed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -947,6 +947,11 @@ S:	Maintained
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
2.53.0

