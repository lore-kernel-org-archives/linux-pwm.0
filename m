Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695243;
	b=oRK76R8/LAwKzc/rS1avE5z8yLi2QTtwavh68zOvtdoLocJX3vheoSfFKf8jrbWHdEVM
	 ujzAYQZBJuYoyKQ5ymCbohzLoNx4f2GD0OvuZKkGQ7z8PQDZCr5+tpT8+IWLONtgMYD9H
	 nUBKb93ggVCt4ee4I4yJ1mUAwlAKI19ltgWYObr0OzBIHZNb3vr48F97+ob7MUtuXm8/A
	 IB/oz0tCcKnpbEK+eggZ9bTUWtRWEQcwimgJD9bXTma+x5PX9TxUivA2/24PBlBgPt+Cm
	 SwTBw8RUXpcr4wv4pvCLB7beBRXxbvJdEW4QlkR4ATKA3A0ZpJKKUo4mwYWAsoeT0kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=JUJOd9ewD2XzFuoXefvfL/kztf8QXUFxcaNj03ZJSj4=;
	b=b5QuxClghmAyzzMrUo1x1SwJwJ8THM4wW9UuKZsLjkWIE/tOgI8S18bqdiqJyHmeO0E8
	 e/IMGVUzu6t6f7eL6OLDNCb356WjvKUBO0ZRUmiCYqtmXOJtJYkLb3e466gTKXrRsGTQo
	 IKlpeFkGf2SGnY1pMWOg/3kDBwnwHzg2AyaedeBUx0mclBpB4DGGdBnh7D4LZgeZlGOsA
	 SNcKirv4NHLUNND0O3FfunePYkcIgpBKk7GoXEvCagBJ87DlYGnAhsg3nv3ixw2dRT/lT
	 Nhfnsek3FHIt0ges7/OUtLCWXlRY8d+6qkxeNDSNMbD3pk5mTe/gQAOQtN7wAyncJkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tOLJ3DQY;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48135606D82D
	for <linux-pwm@vger.kernel.org>; Tue,  3 Nov 2026 08:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48135606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tOLJ3DQY
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-71528ede7b1so1006929eaf.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Nov 2026 00:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695242; x=1794300042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JUJOd9ewD2XzFuoXefvfL/kztf8QXUFxcaNj03ZJSj4=;
        b=tOLJ3DQYUFTqy8+wS6aTVUgmEJDaN815utBQykLJtiywUfcmccsn78sCFPD8ZoSt2G
         aAnrlwTAZcUd0R81aIngQrYfShPsw5b/1f+sc8Pvpb0YW9CxILEJrup3gvGCi3ngRyAU
         CPu/cNvPg5SStaa/HH0Pc3bf3TsfSaIJbu0R0ot7eOHE3JrpS1zUQbwx6nByNeDLjMfJ
         CWr7H/cfO+KEFKPRT+NfQAsJOsajqJk9b/G1x5Zgj5yTcGdqAgk6/J5K7wFSYCp+SdLp
         uSXAt+TynZBZ5IfBVxLwRmOQOtNrRD2Yh/CPIre1vvNVHFNuJzLE/c5watJNX+FII9on
         SwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695242; x=1794300042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JUJOd9ewD2XzFuoXefvfL/kztf8QXUFxcaNj03ZJSj4=;
        b=wwHuoDSi3EHPwBg6wpdAgLJs+WOpIEww3smIz/GhCPzpMV1Nt5GymUnvnWYJ+hVHl5
         2Aq0UMKi/IUFwADGB/D5r5FfXXs+Xx7OmiZwB/hDsdqhKbBDa3cbwJpPQIYJQe11Uygx
         QudO8M2+Zmgqhqv6G+VKHQPIaEqyj5IacADYVv2njCBQHB+hYC75AGFS3VvC6NbFVOvE
         KR16Ro3LFRZwnrHCogsJ4t08OwaTGh4ukdhQlDsaftsOOAxdAX4F+169xVRhwatMi3o4
         7je2X1F1Udo7jgszEWG7e4iRFBjSGx6+r9PY3T4A6idZJZPwOpxrQVWWmo7rOVpuP/ZM
         dIvg==
X-Forwarded-Encrypted: i=1; AKwUvBx02bV0+sUNN2YOMdS9tETQbr2uMt1f9yqo6JaowkMoDdDsesVnPZ4cselbGKW0vytahaa1DJWuuis=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LCdIDN9fkWdm+hUjJgD+GmhsF8MywC19RJJYzWJ0UX7FGNy3/
	NtOIw6Np5A6EbZDjZBv4c7dvP/7vOUz4NCFulfu/yASSsxxKCjRsYz6V
X-Gm-Gg: AYBFou1l+IBdNtSSQs4vzczoP7q9Aoem48EM3jrHj5tgVJO8xwMPdSS1YJgpVpNCGp9
	xdRVFtToCX5QnG/yWER1WS9QWtIdHJjA2xZMY2V9Nr+lvGCC3Y6EZ5od5DDZiUlGOvkCZSZeIV4
	zpFGJSRJBIfXyS5jOjwt1Rr3w2kKX0y58wZDvGxH4j8Se7XhnXeuCFNHl7KA9WA+Xv/41DJkGnr
	6CypmBDHlwKU40BT75/bX+9H1wLrZ2lxiNjN1O9HeZSPVStZdVduEW5jZBLlwoV94/CRBpYzUH9
	iAO2LqDevrJTpng6GefNcUL3NvqXFkn90jMDwnrBu0k9lME+3Cyb5WJAw3mxzLMJ0iw8lLTNd9a
	eZOoGuIKxHKjjR74rbwBl5Ywmfs73hnnCGSX76m7o7k+mD5QP+p6G+MVIGR630atPl4FQjRpU6T
	eS6bSYPi/0L4rUAlY9R/d/2IOGyr9uUjJdpfZOEMSe9a4Qnux0Y7u4tv3NEA7f5Un0BIpHVpQ2u
	sR+Tzds1HXDWH7ovUzBzI+56jSCm6skVCvsCnKlXjAMQBiZhcvqveaVuN35aMxBCverve8CKDtA
	t/J0jHO4PCB7twhMdz3Qi7ermhNKqWJrbq1wvmztOTSxcowht06QfnEToPwY3f5mEz2+BjjUOIP
	aYoj8Mr1PX8aZOVwx/lFcQSlk0JPAKLYH/X1STc4uFLFlx40egcM4UXQrW29/qR7X/5jYvsFLI8
	OHZ869z/RkPg/BJOmqN4DwTSfR5fTX7FwBMBDsY5NVZM6s/wFE6cg=
X-Received: by 2002:a05:6820:240b:b0:710:8db7:5f57 with SMTP id 006d021491bc7-714f2ab5e9amr5840218eaf.78.1793695242282;
        Tue, 03 Nov 2026 00:40:42 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f3081097sm10520397eaf.13.2026.11.03.00.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:40:41 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 01:40:30 -0700
Subject: [PATCH v11 5/5] MAINTAINERS: Add entry on Allwinner sun8i/H616 PWM
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
Message-Id: <20261103-h616-pwm-v8-v11-5-07abb59575c3@gmail.com>
References: <20261103-h616-pwm-v8-v11-0-07abb59575c3@gmail.com>
In-Reply-To: <20261103-h616-pwm-v8-v11-0-07abb59575c3@gmail.com>
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

