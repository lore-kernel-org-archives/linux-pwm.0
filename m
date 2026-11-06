Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983607;
	b=1WydiEkTOVkD4gDJblQMe5ycXQBloIaVteG3ymTx/1vabcIeoqAZgjhxm4rTfb/kxxsT
	 R9ZRvQ+g7iDL6UO2BK87ZRCepZ8RlQAQGn84v2p0Clez4H/sbfO30XqF/Qw9cNIIpvb9e
	 W/2gWXtHjhBVZM4thDeFTuVzXFIGz9fa/vBB04rc0xEyR0glTg6T8sAfdeMFhINmxBKE0
	 PjXfVSNkwJPwjpDYLZb+HNu8oXDwb+xyNXyMBwa5SzUJtr4ggvoE1dYayJHP9pi7X2oej
	 0zTOtG2pl1AsEhpXfDsZ8LxeL8cb4pmD9Y5PvRli9Yaq9jc2sSezVDM9f3Kxv2fr1tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983607;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=T44vUQOuyTxQZZgGZctib1dEyy/T5FQuwuvcOuBU0nk=;
	b=3n4qIEbwkHwyxuyEaNl+Zi2ukHwnF0XmcOerYNC0dQ8rlUwGHPIOfo8bKHWF4wr30eZB
	 7Oy7tnY4ng6vc5L3pIwReuJJl0lDYeFNtAYqIlH9h82ibCJFZfhp+OCQQv51Ymictzzig
	 u75G3YPgx/jC/NpUiMTomsMpFzrNjUB756zyBEIymn7S0/GSBEA3OgLP5PtgNKMt7f9Rl
	 4Dyij5J1Jz5monKRBOr2rw+TZ+ok+dE8TGjeqvEEnCMsG3aWiMx5xwu9C88T9xKzLAAEM
	 Nh2WkqEza72RGZDyJ/9TirJgtWQX+nE2FnG6lj8dpqapC4ih6utWvTvOO+0ISuOT6yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83BF606A32D;
	Fri,  6 Nov 2026 16:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E83BF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLlSj4HC8z8XrrX;
	Sat, 07 Nov 2026 00:46:45 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6A6GkZLq030298;
	Sat, 7 Nov 2026 00:46:35 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:46:39 +0800 (CST)
X-Zmail-TransId: 2afb6aee046f79e-d16fa
X-Mailer: Zmail v1.0
Message-ID: <20261107004639821VrSzjHmPBPphGaXOM2nAs@zte.com.cn>
In-Reply-To: <sashiko-outbox-201825@kernel.org>
References: 20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn,20261107000734514kOTBjwDH_ZQx5Rq7e_WwC@zte.com.cn,sashiko-outbox-201825@kernel.org
Date: Sat, 7 Nov 2026 00:46:39 +0800 (CST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <ukleinek@kernel.org>, <linux-pwm@vger.kernel.org>
Cc: <laurent.pinchart@ideasonboard.com>, <heiko@sntech.de>,
        <ben.dooks@codethink.co.uk>, <benjamin.larsson@genexis.eu>,
        <nuno.sa@analog.com>, <xiaoning.wang@nxp.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>, <sashiko-bot@kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA0LzVdIHB3bTogZHdjOiBCYWxhbmNlIHRoZSBydW50aW1lIFBNIHJlZmVyZW5jZSB3aGVuIGNvbmZpZ3VyaW5nIGZhaWxz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6GkZLq030298
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 00:46:45 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEE0475.000/4jLlSj4HC8z8XrrX

> Should the Fixes tag reference the commit that originally introduced
> the unbalanced pm_runtime_get_sync() instead:
>
>   Fixes: 1ed2b3fca645 ("pwm: Add DesignWare PWM Controller Driver")

Agreed.  721ee1884883 only moved dwc_pwm_apply() from pwm-dwc.c to
pwm-dwc-core.c; 1ed2b3fca645 already has

  pm_runtime_get_sync(chip->dev);
  return __dwc_pwm_configure_timer(dwc, pwm, state);

I'll send a v2 with

  Fixes: 1ed2b3fca645 ("pwm: Add DesignWare PWM Controller Driver")
