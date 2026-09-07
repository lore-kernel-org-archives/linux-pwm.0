Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9884F797B
	for <linux-pwm@vger.kernel.org>; Mon,  7 Sep 2026 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794367; cv=none; b=ZSmppJVATdfKLBphbRBntSnrWjP0YMJ02JN0T5YHO13bAKPYoNw3JBRgPDb8V39gbqjdkka6Iw8nwnGZq0Ert/CugIXyHPfLVEHpN7uaMbjNbeIzbd8urCclkC+wMFXMzEJNfbObiBETkjC5UTdKLkq+L/pmBckPx+zGG3egdDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794367; c=relaxed/simple;
	bh=rcVRS04U4Y1NhrUxKFWvxVXiVm9RAyYBSNeIX0vtRAg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=VOOatLvC2O4y2ABAlH0dNOir8HkergmeWHFNLCHsxpn7g/gMfYJ0CQbFW9KnD8xAsvyyiepoHVMK2gFOb17epmNINeRJ572if1pKVE8IfObAIWIxrgLpYgFh/QnlntFnIchS7maJ30PILyW3xtzT50JWhmfSNq2+Yc4mNe9M+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WcjO6Pjr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WcjO6Pjr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49557167508so44649735e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 07 Sep 2026 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788794362; x=1789399162; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wfsM5V0FaQQokzmgJre3daRZfS2iieNpUVCSCH5e4Uo=;
        b=WcjO6Pjr/Xe21JivKqhd7zW2Wev1CqRRTyYrs3KMr7rXsPgN/kyBafvkLkss6A/Tra
         w3VSjhT3hIvPqhRPyH+52jDaCaIwmiUDn27ZfG1lPutE4HZcoBujAQVigRyDwpULWzs0
         DBpTVYJEDRlosx7OBBWTuNxLqbssSjsYdCeMiuPK9imGgy1/jqJgPzX4CV8bOgye5QHK
         VTLFqrL+bUaNXZDaQlOCPLcQ2lhkrHYialup0OuiGeb9m8dbVrQyYtH208OgQHhsSchI
         fNAeXt59o43+/XyJPFfqmO2hDYKaBtAwMUWLzjQmSexMS90yKGAw/v9szxH1MaDN2Sfx
         LuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794362; x=1789399162;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wfsM5V0FaQQokzmgJre3daRZfS2iieNpUVCSCH5e4Uo=;
        b=Q3JCYo6BwVxSOkxCjE8zkWGO35xFki4EtRQT5aOuuESH9uMhzM1IxlUm73NhL9dj80
         F+yGfR3qPz3VF7X1IElD25xNBRZhhIcSDWzYrzZXgtaWpISL1Op3Pat7TDZFHVWUlvpE
         uTbi8d5UtluCxGeDO9Lvouz2ZcxIv1vt/psRirBmwpBMTRuWno+Ncuj8H84rft9+KC/A
         QIFNdUEmomodGBavelMUdo0dyg8FEyBdewGVGchFjDr/IuHqRiXCDnFpYIqoLdGsDIrS
         DXo0IQU7U6/3c4hdnFoIZuLxmRlKKnsxWPXQqUcD6H16qWTxDsDTjCXIS8IFJVsFBr5P
         Mi0g==
X-Forwarded-Encrypted: i=1; AKwUvBwEDM9AemS/f7cX0DNvTSVgIGkpoD//cbDlqVX8mg0Xwvj06blKC3K476c4qsIM4J67NKkPXyHJStw=@vger.kernel.org
X-Gm-Message-State: AFuF++kO46ELbcBlTbhLkE0C2OUYaD4RvQAhshupkXJugBtF6pdQg2p8
	n6uILOS1G/AzQZm1uyNXcSlK+oA0CBUSVPeta89hrCfQLa+p2L0yGI3VYn2QLHO3upo=
X-Gm-Gg: AYBFou0NONrGUYJsSFOlVRbCFPAo6sqL2gpUjaA6xJ7sMXAS+qFC+wZosTjOOfIS/nN
	c2uYHsJYjNNZExFviJkw/QXOLNXd0/VmmP+Tkeul9gXRW3Cheo54AXC9loMPSjBYrt14ODtiozM
	DTdk31/JPb5DFIPw3uHGo98VPJ98yIUbI/5OjfqpRnBgsBiodpKeJykyDZFcGF5neSVkvsPsN90
	XlVWjjjJAODDWkBQ+dXZuOxtfqj75t9U8xIfZTj/HR990QYzXUF+jWOXw0h7HMrYwx5gBDWKnD4
	TFdblAzuBSKMKE6tHV8AoL8yoHpLlV3ZV2hz6M8Wc2zg/irsXEmb1LDFvemDHT7hYQKXpluXstD
	CyxLfGaUMAGMU3xho5zXgc66fzQ7oO3gzx52GGJQ5XBSyENivnLXiQGVrOqX4GY5tlQb6oeHeK2
	/CqpB3R4t8vpugkqjG5COO2nb9y92nkU5/dhmb16m6T1JW3Q+0WzfYQcSYgkz01tQXRwxkUcoF7
	lUK24RRPAvDXI1OQrTCqw==
X-Received: by 2002:a05:600c:4e94:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49cf81e368emr393160235e9.6.1788794362159;
        Mon, 07 Sep 2026 08:19:22 -0700 (PDT)
Received: from [192.168.7.218] (82-230-44-19.subs.proxad.net. [82.230.44.19])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49ce46696e8sm288040175e9.0.2026.09.07.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/4] pwm: meson: add the PWM count driver data
From: Alexandre Mergnat <amergnat@baylibre.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260827-s6-s7-pwm-v4-2-d28a2015177d@amlogic.com>
References: <20260827-s6-s7-pwm-v4-0-d28a2015177d@amlogic.com>
 <20260827-s6-s7-pwm-v4-2-d28a2015177d@amlogic.com>
Date: Mon, 07 Sep 2026 17:19:15 +0200
Message-Id: <178879435514.2256446.12623877061277695056.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=748; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=rcVRS04U4Y1NhrUxKFWvxVXiVm9RAyYBSNeIX0vtRAg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBqntX6M1dVwwpG2kkr876Epbt5jZrSl70Nlw4AG
 HstsY/+0kyJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCap7V+gAKCRArRkmdfjHU
 RbpRD/0ehx78POhhYnSt521wnujPrwLy1gEErNRrExkWhZysX4QDuXyJy2R8JOv9iSpxCyY6sHp
 OStxUC59Z7yn8cTVgbQufMKwTpINIBqq5eXL8bQhdsmJEy+Pk1/3ww0GAVwSq5ZXHtMjsE0/7eV
 AkW7ix5czGVHop96QPnKwjREam7sb0FcFaRGjR0hs1AAnQEl9DTq2+UFZCj1ikMy4Tz43KRS9qX
 1h+GdCJIlctY0Ge/7SF9+07et3J/2sH3lE8vQRMoPP7wQLB6dXuGbrbv3LYHmXIW55nZY4c/viA
 e5eM4ibjmSZMZCeRZH7T8mDxi5aZTDC5KggxpX120TSlF/RpdsC0MXhtgxg5jA8HLusYvIWV/rm
 BVTWqgIAxnOD2oZSKgE1THvUmZQ+tZ28aeVKEo+Ppv08GZva7gqjPTPTUeIzenyqwqaShfSAQSt
 gsvvXrPntt6cLxx9mVFNvNrcEK7z0FVkpP6Eb6sJW3if8dSnHywjT0ORFxjzt2ppnmSPMM5oMKk
 Su0Z/+5Gnc5ZeZY3CMt/hHdXJdRL4csf3nqLomgLjoJfIPBQLmB/xj8JEaO/So0odhbKv8K0x2n
 0u5N4D7tb2oUl/tf0At1LWLYbd6JgnKZ7nlfiL3OzD3xfYXgt7x8rmtMFDTO9rVbDdJuPI1Bsr4
 /p2Q9nrsCVSI+sQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

> Add .npwm fill the  existing entries, use it in probe, and switch the loop
> in meson_pwm_init_clocks_meson8b() and meson_pwm_init_channels_s4() to
> chip->npwm. No functional change.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 8c6bf3d49753..22cefc6d5dd0 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -113,6 +113,7 @@ struct meson_pwm_data {
>  	int (*channels_init)(struct pwm_chip *chip);

The commit message has a small typo ("Add .npwm fill the  existing entries" has
a double space.

beside that:
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Alexandre Mergnat <amergnat@baylibre.com>
