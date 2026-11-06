Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981262;
	b=lcevUA6MI9quXo4ZKiCJHdV6I5EZGjVg8RwkFvVvRUJC/Q+tJ6Iy0qP25T8WuJVpGyuH
	 psEtMQ4byzRVR7zluePCL6fu4M92TlGv41L4szzyi5B5K1+PIAZhrYr72pEIHWYuLVNKm
	 6pn28PIIKjr+Vz2ehQE8xDK/JdlwVMwWBhL3XP+E/bltFmTZMgpbHa/xlZpwWU8lKEOWh
	 7Wx/4Jfo3DCWo17kJTvaHsASONnYPdQdmhYDhbfk65ZjDKUuhOoSsMLIGqiB74Ax35awV
	 TccOAmPnANSZpDArVNpC8tel2zniQuuh4onxazlDsXV6dp5pey/clqUauoQitvDAH0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981262;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=EsIPeYR6Jo96+xonlsklXVRVXg5dvIEZozXnlmPPpU8=;
	b=UK+OeWqM17rK505CgpalxByLBWtJK4LTETtVMNO3YaZHnZCSMC/bJccGeixNJrKFdSOS
	 30ggU6q6MCi3pZLMAOzEZUDFGVR+n6rJ8GBsSBCbcMf1oXEtmhj/p2eTcoFn5s/AefYQD
	 bi2KCrjcSc7lASO1mTAPvdN4mDDmB1M+sPWKudb+HLu8Tay9DmMHB/Y/l+i3aAEb8lozd
	 4gPhjDtkJLM0jSKvCz+jDD6qroXx9qWmIL8vwU9681cnMtSE/Bzty0o2EthIxCgLyJYm2
	 ULiT52x5rUlp9fgGFKG0tisJmZKEMUF7ZAI+R5iQaoJb5V+erOSQeBPXT5q2X9JQlwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD113606A32D;
	Fri,  6 Nov 2026 16:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD113606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jLkbT3RPqz52SFw;
	Sat, 07 Nov 2026 00:07:33 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6A6G7QAe074802;
	Sat, 7 Nov 2026 00:07:26 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:07:30 +0800 (CST)
X-Zmail-TransId: 2af96aedfb4282e-a87b3
X-Mailer: Zmail v1.0
Message-ID: <20261107000730284ca-NSVCXNk7DyJtBYi6sH@zte.com.cn>
In-Reply-To: <20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn>
References: 20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn
Date: Sat, 7 Nov 2026 00:07:30 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDEvNV0gcHdtOiBkd2M6IEZpeCAzMiBiaXQgb3ZlcmZsb3cgd2hlbiBjb21wdXRpbmcgZHV0eS9wZXJpb2QgaW4gZ2V0X3N0YXRl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A6G7QAe074802
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 00:07:33 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDFB45.000/4jLkbT3RPqz52SFw

From: Shao Mingyin <shao.mingyin@zte.com.cn>

dwc_pwm_get_state() computes duty and period with
"duty = (ld + 1) * dwc->clk_ns".  ld and ld2 are u32 and dwc->clk_ns is
an unsigned int, so the multiplication is carried out in 32 bit and wraps
modulo 2^32 before the (already truncated) result is assigned to the u64
duty/period variables.  For load counts above ~2^32 / clk_ns the reported
duty cycle and period are wrong.

Cast the load counts to u64 before multiplying.

Fixes: 4aff152d14c14 ("pwm: dwc: add PWM bit unset in get_state call")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index 6dabec93a3c6..104393c499f0 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -137,11 +137,11 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * based on the timer load-count only.
 	 */
 	if (ctrl & DWC_TIM_CTRL_PWM) {
-		duty = (ld + 1) * dwc->clk_ns;
-		period = (ld2 + 1)  * dwc->clk_ns;
+		duty = ((u64)ld + 1) * dwc->clk_ns;
+		period = ((u64)ld2 + 1)  * dwc->clk_ns;
 		period += duty;
 	} else {
-		duty = (ld + 1) * dwc->clk_ns;
+		duty = ((u64)ld + 1) * dwc->clk_ns;
 		period = duty * 2;
 	}
 
-- 
2.47.0
