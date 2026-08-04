Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3765472F8A
	for <linux-pwm@vger.kernel.org>; Tue,  4 Aug 2026 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878866; cv=none; b=asbts9nL48Z18zEbRPltEIkWQGtN2BMLiTo7lHNNT8KbqlQfvjvGDNaTozydVktY6An7Z+VfvWPGBuUxbXUpVJwLROfk4lPajkdYTBZuJ3Q/m+HlWUQgTfX8r7dM04Qd0Gg9tMGRtdDJ4Ed6BZVmjPRUR4MC/o8THcfxFfsbTCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878866; c=relaxed/simple;
	bh=VGb1jfHkMVxOapYytE16mS2xansj6G9Y/AJehlGO+Js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uG4yS5KuM6LRlKMr4p/h9L3z83em/2XKYSQ+10InF4ME5sLzlSsQRijA0PxF/+h8q9nyvoytkoDX7uZ8cOSFcty9LxnsbP+wt2xIGZBeiQHBCcat1445we77hGM6eI7zPyyd1455FGwQprVB0y1XXc5Ig+eIZ1T75dcxO9QJREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvtu+t+t; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvtu+t+t"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-497e6956acfso262421b6e.1
        for <linux-pwm@vger.kernel.org>; Tue, 04 Aug 2026 14:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785878862; x=1786483662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Elx81wKiFvHIBGMAjiuzWwDTmSw0D6ljnUBG1nDCbuk=;
        b=kvtu+t+tsQ7cgQj+kvLxPTl/mdyHybY/wrU+1zi/IqsR1z0UvAyUeiX29feDMa+42R
         GHbPBYQSG80U6pgSFMhs7SI7gBXHFf7ccxIXyGxHw3T80GlSDr3CPyzd6CV8JIq7uBA1
         NuUwtTaoeGKE0oPe+A1mtNAIgptR5Nxz21JtXSUZzfTdG9gP3A41uSPceD9n5vgKrJ4h
         XACuFSYjXF0ZfSllMP9eM/g11W7Db+fuAaIl8uwd35ihR7Ats3OMsPtxUisPvoB1pvBb
         +ajqznPp38wqFy09PxwoJilwhrRVIw8OKWYH1WFaERT5e6zgfSV9fXiZlyz0Qkk/xAzF
         YR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878862; x=1786483662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Elx81wKiFvHIBGMAjiuzWwDTmSw0D6ljnUBG1nDCbuk=;
        b=HvyZHHi3O//z2zOAUUOuGBw15ZutsfIUKuRQmuBpWrDXkiqon9uOoYtt2Flc+bDUX4
         0v7pgV6pIS/RIwtZs2MdoaqzKZjSMH18/k0auo7BFLcspT2smmf8J4lIFG5+4mvmHRx1
         3eCoK0lfOkwCSgnC+olaZvTnSyB+IDAz40OCvX8MR79yvLL1UbkzB0BtHv8Ylr5pH1SM
         sb1Ejy5pX0X+1QXwAMSUy76JD8vY8X6v4sseqVJdZCybtm0mAxgVkBzeehNfwfQYnOTK
         9v4yUR0/X27dTV/em2OkPZGw4XQBOB2/lF0oSCwAK9TTNtny5P1isUj5ezq8ab31se61
         bAYA==
X-Gm-Message-State: AOJu0YwpgVbTt+FfDRod/BCwWBsjL1nhwThYtFW2Guf2Xac5SHuDCXkE
	NLoS+ROFR4bLkFdTjxD7lzCYrDvIaVxdcyT0rIQrRDcwSK19NKB94QH6
X-Gm-Gg: AR+sD11ql1bewW7pplBp22WOJhsq+oKFbxczp/Qb+6w8bsHfIlQrCo9Y7ret/q+/sa/
	+YSUs9UpmQOjSH0fuXeOArOuDBquy9Fz6ZLlIwcTbVvuCoVM94bMPcuK0KpV8H5ooX0kwQxnaBb
	0xclsNrRB5pSghAbSphj7lU/eWVej2g9CtTz19zd0lMijnxI7rcBHrL/XYD0wJ/6B0h6TBkQ1pG
	zBkdaLY8RFz7b/kCH+0pdKjodLgu/u6pKx9YSFRJoxNKg6Om3/iWlPDFudDRnuHIoqEWU0Oj/UX
	I2iy0MoubMJnD5GjThnQSNFMBQ+R1tD9eslUkrvUYN5y8UYyrOLk+sAt3hQ8U5MBnDqLlAKFH1J
	X9MsQkmHl/wvwD5hzj8omGcYJl8y8UpvZmziyAqJtk7F0tU4GgIgLE0rm5phlhbTsBcSM440D2D
	kb0YLAfr0l2jhgzqtqJW4CWg6kji7Y9m921iAa75Vs376g2H95fAfuYsyZOFePDwzLp+zegAINs
	vkSSqkT69fAK8aB4McZFzUjxOVAJTAym1hYeOI5RM9nmNrlEuGQbvHQ3WseubXt/lQgdzp8UL23
	RUGEFg7Ggz7Jy1MK2aCh0ldQ5F5iZkbGUM2S4eJehEV15ddV1MZb8T8Q8bmhOh3D3nHxnopNdkE
	W/J90xKu+q5rEuEmuiF8p0rKHLkw=
X-Received: by 2002:a05:6808:3510:b0:4a4:989:bb1f with SMTP id 5614622812f47-4af98935a91mr6058342b6e.9.1785878862648;
        Tue, 04 Aug 2026 14:27:42 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae7c50e9sm451659b6e.17.2026.08.04.14.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:27:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 04 Aug 2026 15:27:27 -0600
Subject: [PATCH v8 4/4] MAINTAINERS: Add entry on Allwinner sun8i/H616 PWM
 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-h616-pwm-v8-v8-4-db37ab8624ae@gmail.com>
References: <20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmail.com>
In-Reply-To: <20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Paul Kocialkowski <paulk@sys-base.io>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, 
 bigunclemax@gmail.com, linux-clk@vger.kernel.org, 
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
index 5114e6db7307..9a778d1242c5 100644
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
2.53.0

