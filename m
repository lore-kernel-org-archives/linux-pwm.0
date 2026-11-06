Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981262;
	b=3SyRQhE9cDmMYZMt3+UgET1YfSr+YN8PBfqkYGptm1lnc8E9ybSkDzTI/MgzFSsldl2j
	 LkTCoHQrQpCp+/BqlJ0mPMp753N9L+Mb18Q+Y6WXcAMHRYH1udV3AXPVpB0mFHyMrlnhG
	 rhxrBy6EubECSZAMvMhIkSFQVm3JKn1lEWgI8cFRhtMvzd3gGM/lD8DoyJiTw0kPJZZHI
	 cCfUPWVL4uu0Pww/aKLjOgreGA6iNXGdlyOUbsVusBmbgEWG4M/zmasLmmSjdJFd46M6P
	 g8d2DH4XhDftqJ9c1SygaQxzQ+cbnMOvlycz6QyUO5fhO/vGKCub+ZuIMCxSYHx3fxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981262;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=I1ykeWhkmtXgB4gAWfQsNOu6wpvtLcTBuy6VsFFxqKc=;
	b=J4Q5sr3wwsmtNZ2snmHhfSa04y4x9jiI6dKJZSqbXnyr9N3vuMG6lFQBECQ4Vkmsm4vu
	 S2/8s6jdFp0b/unSk4wryoRZ5fRB4SkcB4NCJKW1gWfMeszk5mXuQubiylDsBw8ZKeruP
	 QL6y6QG+hkrZ3jrb+9T5R5dSGevIs3MXx6471st35uAD76CRRGs3kfCbtIFHhL4uGF45J
	 ePAA9M3NHJ9QLPKGO+ZAjt4mj+VNm8EgDUxYZOIZ86O9PGDvJLUvla7FiXOUXjtQluoCL
	 Eiu965SqEcb4qyVmDXTgVwb6P10z63stJgNpdooh1IeK0anv7qt1yUlI2GSPygPN3RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB984606A32E;
	Fri,  6 Nov 2026 16:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB984606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLkbb2d9wz57DCn;
	Sat, 07 Nov 2026 00:07:39 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6A6G7SEV074852;
	Sat, 7 Nov 2026 00:07:28 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:07:31 +0800 (CST)
X-Zmail-TransId: 2afb6aedfb43448-ac3c9
X-Mailer: Zmail v1.0
Message-ID: <20261107000731690Wr3rd4QI5xuQo32vYb4OV@zte.com.cn>
In-Reply-To: <20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn>
References: 20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn
Date: Sat, 7 Nov 2026 00:07:31 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDIvNV0gcHdtOiBhaXJvaGE6IEZpeCAzMiBiaXQgb3ZlcmZsb3cgd2hlbiBjb252ZXJ0aW5nIGR1dHkgdGlja3MgdG8gbnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A6G7SEV074852
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 00:07:39 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDFB4B.001/4jLkbb2d9wz57DCn

From: Shao Mingyin <shao.mingyin@zte.com.cn>

airoha_pwm_get_duty_ns_from_ticks() computes "duty_tick * period_ns"
where both operands are u32.  The result is passed to DIV_U64_ROUND_UP()
as a u64, but the multiplication itself is performed in 32 bit and wraps
modulo 2^32.  period_ns can be as large as AIROHA_PWM_PERIOD_MAX_NS (1 s)
and duty_tick up to AIROHA_PWM_DUTY_FULL (255), so the product exceeds
u32 and the reported duty cycle is wrong.

Cast duty_tick to u64 before multiplying.

Fixes: b55bbc2872eb ("pwm: airoha: Add support for EN7581 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---

diff --git a/drivers/pwm/pwm-airoha.c b/drivers/pwm/pwm-airoha.c
index 0cf6b011520a..702c9cfc0e37 100644
--- a/drivers/pwm/pwm-airoha.c
+++ b/drivers/pwm/pwm-airoha.c
@@ -152,9 +152,9 @@ static u32 airoha_pwm_get_duty_ns_from_ticks(u32 period_tick, u32 duty_tick)
 	/*
-	 * Overflow can't occur in multiplication as duty_tick is just 8 bit
-	 * and period_ns is clamped to AIROHA_PWM_PERIOD_MAX_NS and fit in a
-	 * u64.
+	 * period_ns is at most AIROHA_PWM_PERIOD_MAX_NS (1 s), which fits in
+	 * a u32, but duty_tick * period_ns can exceed 32 bits, so promote
+	 * duty_tick to u64 before multiplying.
 	 */
-	return DIV_U64_ROUND_UP(duty_tick * period_ns, AIROHA_PWM_DUTY_FULL);
+	return DIV_U64_ROUND_UP((u64)duty_tick * period_ns, AIROHA_PWM_DUTY_FULL);
 }
 
 static int airoha_pwm_get_bucket(struct airoha_pwm *pc, int bucket,
-- 
2.47.0
