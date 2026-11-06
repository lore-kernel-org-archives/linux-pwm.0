Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981266;
	b=JLgsP9OH4ozNOyPG4PbaNhd+c9AKKoIVApL0rAi1Q3eLpysGwTXRyj+7ZE/IJqJX9Nid
	 yE8aP1LEOMwXfOPDUqjlayI2pFt6vUBb9BEfiYalEoOVDMJnfwX6tcsJiysttfDc0/NBe
	 nThwy7omVzlECRsXLIqlJXspqqGyO+ZLgKPk8lTDf5MwhNxVBoL/pnw9l2eV7eD0IETDQ
	 7bggbqqLVZkVfU8uxZUPJKmACTKKyWeEju3C++3/LOndbPa1VL4zphCp2eZFYT1u+/NSv
	 3Oh8fMPx++gevkUBRJMXP5bFDlD8d7EbCypxpIuvTeKvjTBDOb5UBJKZMJPCIH9TBhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981266;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=uPp2fzdLBY5CHwdH8XzdM9YAI4i0kmB6xApoKj31VXI=;
	b=dX8c8XWqwvf8Gsv7H3GpmRXtjGRfc8TdU0hzhPGJSHfroO3jF8+cl5zl/sJ9rQzj18DN
	 sp17ReslYCWHN+eXJuUtmo8aXt4LuQIAZIlykD+e+n48E2zQb61kG+yDCGRSnyUXnwJjy
	 9qlOOUiSg/cWqJXGQKVeJQzM/yyFssvBm4s/9Sppg0JJP754jTNJNpagyBcyJQvztGMD9
	 oI1YEZtgE4T0sS8S25Zyd5Xi2VljBcv4jAyrvh6Yuk3vbGHgLcTRp22qNEYgQe/MycW7s
	 pRujSJjJwHI9wVGJqu4kZqy2cXE8USiPnRu2NJbgDp3v7gDiCEUy9afkXOzhaW9GioA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34B4606A333;
	Fri,  6 Nov 2026 16:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B34B4606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jLkbY3VX5z52SGM;
	Sat, 07 Nov 2026 00:07:37 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A6G7TQH095448;
	Sat, 7 Nov 2026 00:07:29 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:07:33 +0800 (CST)
X-Zmail-TransId: 2afc6aedfb45277-a81fc
X-Mailer: Zmail v1.0
Message-ID: <20261107000733118AdMi1NdZNf834PvT-O3bC@zte.com.cn>
In-Reply-To: <20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn>
References: 20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn
Date: Sat, 7 Nov 2026 00:07:33 +0800 (CST)
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
        <linux-rockchip@lists.infradead.org>
Subject: =?UTF-8?B?W1BBVENIIDMvNV0gcHdtOiBhZHA1NTg1OiBDbGFtcCBvbi9vZmYgY291bnRlcnMgdG8gdGhlIDE2IGJpdCByZWdpc3RlciByYW5nZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6G7TQH095448
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 00:07:37 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDFB49.001/4jLkbY3VX5z52SGM

From: Shao Mingyin <shao.mingyin@zte.com.cn>

pwm_adp5585_apply() computes the on and off counter values as u32 and
writes them through cpu_to_le16() into 16 bit registers.  The period is
only clamped to ADP5585_PWM_MAX_PERIOD_NS which is 2 * 0xffff oscillator
ticks, so for duty cycles close to a full period the on counter can
exceed 0xffff and is silently truncated by cpu_to_le16(), programming a
wrong duty cycle.

Clamp both counters to the representable range before writing them.
This is a saturation, not an exact mapping: when the on counter is
clamped the programmed period can be shorter than the requested one.

Fixes: e9b503879fd2 ("pwm: adp5585: Add Analog Devices ADP5585 support")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---

diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
index 9a1dbba75bc1..da83fcd35e1d 100644
--- a/drivers/pwm/pwm-adp5585.c
+++ b/drivers/pwm/pwm-adp5585.c
@@ -96,6 +96,13 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
 	on = div_u64(duty_cycle, NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
 	off = div_u64(period, NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ) - on;
 
+	/*
+	 * The on/off registers are 16 bits wide, clamp the counter values so
+	 * that cpu_to_le16() below can't silently truncate them.
+	 */
+	on = min_t(u32, on, 0xffff);
+	off = min_t(u32, off, 0xffff);
+
 	val = cpu_to_le16(off);
 	ret = regmap_bulk_write(regmap, info->pwm_offt_low, &val, 2);
 	if (ret)
-- 
2.47.0
