Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6975B49B218
	for <linux-pwm@vger.kernel.org>; Mon, 14 Sep 2026 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425145; cv=pass; b=VEiMoai5nWxZcAJYQoMjiPczx7kUUgJj6QLz0Tvx83lU45/rcjVqJumkEpqgM9uMbFwdWKLbl9KJlw9v3fDzMW+6e8BIGIv/0ZGYYcQR9tN7MXfIEaebNsmxhrcAuXYLITevoih60ZpRWmgFb4qg2kJofILTDy5rlJsaECu7lv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425145; c=relaxed/simple;
	bh=RquOnyx3oonNy5ot8nKZ+MZokFOsGOyqVbKyPQz73Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALHAfxH8uPF5f/MdOeNasgkdqRcWpYrkzwVuNm1rtWzI45zZ+UJYtlaDmd+V5N1OPZ6rkWaJjDjNs6XWPRV7YG+8seCy9YoJyUWxHdxQwuuRvRrE+aC24DuUC957+q8XI3Dug+HeCy6HcHiFEV4MnO6sxFwFsyk+RZOfzFVPGQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhPj5FJm; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhPj5FJm"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c299de66a99so277600466b.2
        for <linux-pwm@vger.kernel.org>; Mon, 14 Sep 2026 15:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789425141; cv=none;
        d=google.com; s=arc-20260327;
        b=OfRLLRQ5rLIsbZuPiwuFqt+HWTbwDU7otaZlo9KJa5+0y5yG/GOLdIGG3K2+8N8RQX
         lBV0GFie5Q512A+eRF1RkoqT1Z626apYgz7zG7iFrT7Sc8OiWHBr59LN+zsT31Thv6CK
         5FvtSaCzx3KwQw15wPKXv43Tbl33MyIZG/fdLTMpE2QVO5aakK/YZno7Gpzt2P2L0P+A
         D37Er2AG0a4BnmbEnXsfpfREDKlhOIs/ca0LwUxoyHmPK6KrN+z5EJiwHHOHDs2TJCHU
         WSmGql3s0s0U8mJWl0qQWQDLvTL81Y/RTc6JBaEyFIdZSv1c+OGpy5lhwNua8l8fXEz6
         FapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RquOnyx3oonNy5ot8nKZ+MZokFOsGOyqVbKyPQz73Oc=;
        fh=PzGPRce/VY02aghTVLuLYuGYcE21Z52PeL62JwBZ/vU=;
        b=Y+IQR32NFCw8wxk9rPvEhTKKsdfJP7Z1x6u+Q0LM5kreqbc4yTfl5Izr1g92Olavsr
         nIum0ZfuiSq6+V76hjhLGlte6hqqktlW1kJQUc9fGmnfD23vd0Sl+iPkbsKTCIl9fYUT
         Hw+XbAkrOrAClEeHdx2nziGWn/BAbjgidyauZ1LGlE5ovOTktXKlo6kWM82Heqp5dQIy
         XdTrWPEpL6ykoi1z/SQ5dM8XCi6+esN2gF5yIbs3HGolmsuvTq/04BZV2sSeOxdI/4Kv
         cUOAQqlT8pX0zltfdJdgQtQDmhcWlFGq185PgtlAjltAWw9wMk53c++fX0pw9m4GyQIY
         BT2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789425141; x=1790029941; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RquOnyx3oonNy5ot8nKZ+MZokFOsGOyqVbKyPQz73Oc=;
        b=IhPj5FJmufRo3u88fDdRaoH72K7ArrJLOpQdJOy/gGKFAzj5XxIsE1+DnLI62xZ7s2
         uZxS/2/4Jsc8ZKgauCEDmblqng8u1BrhRc8LqMNyKOlffq0wYMKglT0CMC+ffE1C9Brb
         xJ1yoBz02BKSOmvwCKhUGzpVRb6ARPoHoJ9ISwKjUnxI4jgd1V6Te8tgCHwE40DO1Sx1
         3XMTIOBOvLnRt+tF8dOZd86zRfx2I8HJHaXccOazmm1PLj1GhbruuPTYa/n1hse7ZA7r
         pJ24yVdyytXwPeykQx+/b2ozLANwCLzRr9QO+UNitQWn7L8SO02rrXi3p/AtybyOyQMe
         vp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789425141; x=1790029941;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RquOnyx3oonNy5ot8nKZ+MZokFOsGOyqVbKyPQz73Oc=;
        b=len68gSbeLvyaBjTvBcawUR7hkUeutSMAcK23C3R21hWeHtPKjf0WmhMblSj7d6pAm
         SxBs1AZp0LtUnaIwdbFeUXL87ni3Pq2XiU183ao/pzd5s0jiI65kAIkjNoiFsM2Gu0U+
         32+/PTOGHvZN7HJrfK5o3lF0DsVKsFb53vIUncMINoYWrxkJsNbsScfUTJ/qyGv4dzBc
         X7HHSnfLHl6l6yVOXYiDdSm22DdCpUU93A/61bHXuJ8QqeQdx6HtsVS0el4FEm4RM10k
         hhoPa03pdtNz2yeDIX2jNJ8BCevrwYx9CZlsaB3Xo+nTo2OmcdiG6Z2LwctjxUmbq4L6
         f3hQ==
X-Forwarded-Encrypted: i=1; AKwUvBygsLFjZRQ2IsNi8olXV/xAsySViZ0lfU52VlUmDV/pjzzyeLDYPthD+XWny4FKAoMZIEhTrjS1JgY=@vger.kernel.org
X-Gm-Message-State: AFuF++lE5uldHnRIQGXTm8XOPkiIl9hXf3K5EOKZgpUb/V25ZwxVTGmq
	wOlxZ5oZ+ekrEIGxhrqot0NTJdiayeiUqwFze4JXILOHpf1O1wuvcztHBbXk0lPsv8nUGdLNarp
	pydJHEOxb05im1yw30MoTnDwlyptADg==
X-Gm-Gg: AYBFou3fx5sgbp1v9lVb+NVxAlBPwqF/1QOCAUE+/8o7jLeKPpbQeNYNdkft26uPyV0
	SEfpWY05FpwuQ3L8Lw9OqEDgL9yMMRZwELpHcOCJgp4AyTw22+Wjjn9Ch+vH2MzvpxVvI2XwyXi
	x3HknbSEK1NFJaRQTPcOMw9uGytGlMzYU6UaDgML98GPnzoikyryaxD/zmFxSl2t5LsmLQ94oBI
	uOCBA7hMhkzZ4ALHPuWQkMBYrTOEc+W05AF2GD5kL93owIUNjoqfeJWih1sHRrloVWrMfK7LAjP
	748fnpVFT+7gpQ09rq7gDi3+QQvjn5q7uC72ji0jjgkoOYziuQ/mMjO8dL1zMto00BeMK34Y6bD
	ICicOdW6yzgDLj33k5mMB2PZDKSue2w3o3LNSkvWznM3rihS79qdKDjwS4d+BnkxRk9vA
X-Received: by 2002:a17:907:8e07:b0:c29:45ad:7afa with SMTP id
 a640c23a62f3a-c29b804bd7dmr277377066b.0.1789425141394; Mon, 14 Sep 2026
 15:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913040606.23272-1-mhun512@gmail.com> <RjVH6lTrT_KugcUQV9puWA@nvidia.com>
In-Reply-To: <RjVH6lTrT_KugcUQV9puWA@nvidia.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 14 Sep 2026 18:32:08 -0400
X-Gm-Features: AcwNN1UpzBAoI25V1FSIL5wEhSS0QLs7PqvCPS_cC5XA-rgMX6mik1qtVrFRyMw
Message-ID: <CAGEsz8GawAJyAXbksWUJRhUWR+c8cXbn-AVWfd+kgLwO7ZQmpQ@mail.gmail.com>
Subject: Re: [PATCH] pwm: tegra: Disable runtime PM on cleanup errors
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pwm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Thanks, Mikko. I'll use devm_pm_runtime_enable() in v2 and retain
cleanup for devices that remain active.

Best regards,
Myeonghun
