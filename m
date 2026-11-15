Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794780808;
	b=Gqh+47vEzXN+uE4ABBmjNEY1/dVL/6H+j84T2h8ZfuhQF6S4RfpOmLobCbGLmpSJQ7W8
	 wdGYEDWyJ9zp86oTg3+ewHg0YdcEmUryWtjosJJkEj23HJMerumLruqgh7X7jHB4l64Iu
	 h7lYSIpNo0nmVwIaqt6jRFkRv+Z7xZiItjG5aCPECUucXOWXXjyEgupnpCAibyJRz9f9R
	 THqxjiOSrMYbcDpMuK5zB9ncSqrOcU1YxfgEV05pB6ZFa4gC/7ahWCzWT4wh9867naPDx
	 E5dgUb5BDvNXaZI0tpGH6ib1KJa1iquizxZBjj/TCBxZ/TMzgUbGUBW/hQp8QigKPQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794780808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kJAkRdpNaj0JXIeCqo3bYKeQ45IEZOOmHicMvNGpVtE=;
	b=AGOdZXctoOCJ+CCK2ZnvHmqbGtYkwuORPChXxxhMFS+2wDl7BzyOlN4LWZtjcQzuYrg3
	 cKiEXUADzWX6HBHIeL8SfKgF3Om2spvlRHS2S2HE/awDaXITl4URd/1U282ItqEfhJY5s
	 HZJdLi/YiorH4dOCVKPot3G6bbYgudNVfKRpkoNH2Jy6fbNIhHJlUSQ4fIDqXkewNpxz5
	 nuGU9MEQN3vXjQXGpVIG46eBBBjf+/x5FaYqy3h52A/pRVsp9rWaqFNExTIeahK3Wspge
	 N45xCK2bt12RhsEBhcz+nZXuRF5Ab4P4hfw5b+wDh6WmYD9HCiFxWoMlq3KJKGUCInQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b="KeOT/WJT";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B8606A332
	for <linux-pwm@vger.kernel.org>; Sun, 15 Nov 2026 22:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F8B8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=KeOT/WJT
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67da69e7c31so1018089d50.3
        for <linux-pwm@vger.kernel.org>; Sun, 15 Nov 2026 14:13:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794780807; cv=none;
        d=google.com; s=arc-20260327;
        b=gmtK6M2ioNfV+m17NS+o9DRWMGK3nt29nRGB/zSNm6ZGgSNxlRwxUemndyUEEYnLKq
         ZzvAm1ILPBeG9Gctjj+9v7pTplItqL8wkDcc8ytiJMBI3tKhClppVZorIltake1N0CNA
         YDESTJYICVQ2I1QifXe8w5p/nHRUL+f4d4AcpO0UhqL3bHydY7oxhV1GfNZEHTrG/7cI
         KTQKzeAIcP63fjboHEL/nxezNzLaHMOgF217F2nWdcKVLaLDmZytwgwk3BZNGAewSWcn
         pC7zYbLV7itfBsMHfxQCRo2XuTgqj7u1flYMFkU9yQsUQD0aM+STcHftLFrANnToGWws
         C+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kJAkRdpNaj0JXIeCqo3bYKeQ45IEZOOmHicMvNGpVtE=;
        fh=cpMFEQdf7UHkc+HCA7l3TIED+e4Y4KMaIMHEdQ72LH4=;
        b=r60UfGr+dYWf8MdqkPSfiHQVyG0YyMWerpf+Fr4kQAm5i/L8y8N/X3Dp1gL1+gTI/1
         D3BdaYN/GOp2zy1zixn2UnLt/O7RDSKzx1/LpUk/2n6DxvJhj7eNoqrpMRbGBUKaQEqD
         cSQ0DZelU9jG5Btxckzpea/6bjoTmz4nWccRS2ZJJIry+pNGP9Z3RO4Hgp1CdNITq5CS
         1nCXnXPtuP31Hnrw0y2DrepDzKdgX6Qt1eucjOqaRAZzM1pbfmWBYnuU2qixtdLKPSne
         D1Wbcalp6OkT4RD3eoInunJZmReoDxCFDBVyxDHnfMzpTmZTwDhgrcNncbsZvhkXy/w/
         iiLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794780807; x=1795385607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kJAkRdpNaj0JXIeCqo3bYKeQ45IEZOOmHicMvNGpVtE=;
        b=KeOT/WJTkV/xO3s3/8ho6ndXpXXmKFe7CrwbymmlzfKNpL2wgykSqq+IbgR5PB4lEk
         Z3a6hnz60Co8dAtCWycw3vFlsCiAXYgV+gEEcdAiy0LyoIOqz1HOkB5J/r5RDJ06ZkPV
         ns0QiBSOEvZuK/yRJLyW0/Fcbj6KjiJcfqDPlqIBjW32EqGP4EaH4z2Wz3ERrV8B/N+D
         Y2I1ULu5cmJpR9AXV2tEugVzDWvFRMeJHUnyPYNyJnBQ1POsE1b6hTyTc5c0SDzVaTru
         2THBO9lT/A75TUQGP0fbrtrcyN21R1FFWCAwizN1ehsTfSkmcunisv0Q3nXFibwfR1XO
         2N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794780807; x=1795385607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kJAkRdpNaj0JXIeCqo3bYKeQ45IEZOOmHicMvNGpVtE=;
        b=etzMVI7xg+W8H3jpkol5rQcKMOHAD8VIw+LhVwVZTf4/PWy+fpvZeQrS5IO3wsJ4/v
         YaczRVoCdk6EsCCyIgM7uO8iLexlXxoBWPVo2EfJcNWhnCPX533TfRu8G9WpdiLVcbOn
         TOEwDt56E6+1zD9AspgoRKL5j5l/cO3d/JxMpO5xgraMtnitd1pL0jCrgnELqJhxH+7X
         hPYjMy6cLAuD1GmQgsAhd7BeB1l5vBhK8WB3/GpfylttcOYbqzpqQ7m1jG3NDiKfIJMr
         bj6sbGd3VjpE8Qh1rqzT2Mq+AI9SaGzzW2yrrvqUVRVUQ7mdE/nrIT6r0pzQBfeJWZX9
         LhHg==
X-Forwarded-Encrypted: i=1; AL+hErF8TWmmifkvrUqX1uWZBqsApbTEOLxinlqtUbv6vL8txy2YhMIfXQ3SojMWSQjW/PsNex8s6hkYor8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4LFdHE9EJXwWeETVuP91ikWxZXDgXDR+fWGh8TM+qQvjQBmqE
	nPjWr9cHxtnE2pT2MQUtR1s6djdpXsv/2e9qn8HdLr1YBfF+eQc5AX91tUH4DtyELMe44MwaxMf
	ekZxBy/FkHDg3KaB6w2wJuB+mMJIQ4lY=
X-Gm-Gg: AZFdTZdI0nTVuTAIQXkN85r7NgCzkp5RXLiWKo71eRWxi788uUrAeRbNabRd8wANBaf
	HC2NLAJClXDxTx+y968JtCzw4go+ppJ1lDl0TD8HtVuj83js6jkKpIyt/W2t4neZg3QXjly8ypt
	hy8JhXKgOFygYRtcakMvqcvMWXpu2XOSPgmRUv1IMX+vGml98anGD9dupBXNDr91JCCcwGU2bcG
	3vkO87npfKe1j9rK0wI6mFpBcu6i1e9uC3QvLBFngYGOad2sBv2Fdi2Xyoc2mmyu4+5ag3WmkUA
	ExXQpAoyrvXKXqnh/2whr0fuI2Q/pHAFh5/90AClfhWrPkxcoIi6IHI5KHUzAbaK7kdPmJGhF42
	Kh1z7mWmaPtDHYT184Xkz39Lr50G6oOeYMIhsh9EN0MHHwTDOmcSYdQQRw8oCJHrgRJgSwA==
X-Received: by 2002:a05:690e:47da:20b0:67c:2ae8:dc7f with SMTP id
 956f58d0204a3-67d895a8de2mr3616052d50.26.1794780807215; Sun, 15 Nov 2026
 14:13:27 -0800 (PST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261001-add-t7-sys-pwm-clk-v4-0-8ed2b1e0cdfe@aliel.fr> <20261001-add-t7-sys-pwm-clk-v4-1-8ed2b1e0cdfe@aliel.fr>
In-Reply-To: <20261001-add-t7-sys-pwm-clk-v4-1-8ed2b1e0cdfe@aliel.fr>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 15 Nov 2026 23:13:16 +0100
X-Gm-Features: AclHuK_5guKUt0BBmOKSaBjMvD6Ef4THAVZjtyLJDUGu11vns0QZX0fCV-z62Yc
Message-ID: <CAFBinCCBZTN8m+u+VyR8sijC8ihaQR8woBtG47LJ7tw_ftbO_g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: amlogic: Add bus clock for S4 like
To: linux-kernel-dev@aliel.fr
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 6:56=E2=80=AFPM Ronald Claveau via B4 Relay
<devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>
> The T7, A1, C3, and S4 PWM controllers have a bus system clock in
> addition to the two input clocks of channels A and B.
>
> The channel clocks are acquired by index in the pwm driver,
> where the bus clock is fetched by name, with optional get
> which is silent when not provided.
>
> Require clock-names and minimum 3 items for S4, and devices
> which fallback to S4, where the PWM devices do not work
> without all 3 clocks.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
