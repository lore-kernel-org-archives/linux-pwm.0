Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981268;
	b=XGgtodxzgqe7Cq+LxdcTmRT4+7/c3e8yMnjASKl2T+kyJbu6534nv3uqlYX3Jwj/TZxJ
	 VXK/X8OzQ+xHRsYF/qlG5e/UU/J/RxMRllwnMsFy+hGG2BFA4inICAFcQs/uOmr9+VxyV
	 tzZVjeLQw3ADqewqKQWF91RiY/FDkeD2V3WfC7Gdubnw31z/2nIG9FWEsHLA/XAj8D6ps
	 rtqEyZDzoiZFWHSKlUqompe+yhFL8JOEPfjSm9v1E639kl4jm0T1a9zQqX6muKKctGn1t
	 S1haO7cQ30itxy6IjDfz7mkf7o98FCeFP9PmJkj7N8ZZ3u9wtyfbPHQKKZiiIuykURg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981268;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=INSoL3TMF1qerr/Tqvdxd9HHtvc+puZMRlFp4ue8+g8=;
	b=GCK42Cr/0wRKYbQkGRdAyy0VpVgZAM7F6SKvZlvJJikfTh78SBaDNkphX4buErZx9F/H
	 XPxLW52XT/k+b0dhl9t8zFfmK5L4EcQ/nB473FGABwUpaPNpyRdoaMLPkUVbF2xmFGjGc
	 mnf61fhFkMbjBKj11j4/pytl2JiCZA/jpC2CffeRMLQ6ZR0drNChz7/ngEEHPCrnJjeq0
	 I4h+lgh3PqPrY1oSg0G0bhnHrjdgmjRyw5LpCqpbvamyj/dOzTH7h4IYHyEGxd/CuC8iu
	 kfH/8E4syAHcDErOjlP6j3NdHv3wk/FlcZBxAuvDyiGgAV4TvAvlijbxNAe7i//83Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2D606D808;
	Fri,  6 Nov 2026 16:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF2D606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLkbj2kFzz8Xrrc;
	Sat, 07 Nov 2026 00:07:45 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6A6G7W5S095561;
	Sat, 7 Nov 2026 00:07:32 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 00:07:34 +0800 (CST)
X-Zmail-TransId: 2af96aedfb46945-a88ca
X-Mailer: Zmail v1.0
Message-ID: <20261107000734514kOTBjwDH_ZQx5Rq7e_WwC@zte.com.cn>
In-Reply-To: <20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn>
References: 20261107000724697MsR-XmE4V-ADPPMr3wGom@zte.com.cn
Date: Sat, 7 Nov 2026 00:07:34 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDQvNV0gcHdtOiBkd2M6IEJhbGFuY2UgdGhlIHJ1bnRpbWUgUE0gcmVmZXJlbmNlIHdoZW4gY29uZmlndXJpbmcgZmFpbHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6G7W5S095561
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 00:07:45 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDFB51.000/4jLkbj2kFzz8Xrrc

From: Shao Mingyin <shao.mingyin@zte.com.cn>

dwc_pwm_apply() takes a runtime PM reference with pm_runtime_get_sync()
when transitioning a channel from disabled to enabled and returns the
result of __dwc_pwm_configure_timer() directly.  If that call fails (e.g.
with -ERANGE for an out-of-range duty cycle or period) the reference is
never put, so the device never reaches the suspended state again and the
usage counter keeps growing.

Put the reference when the configuration fails on the enable transition.

Fixes: 721ee1884883 ("pwm: dwc: split pci out of core driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index 6dabec93a3c6..cfeefae68969 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -99,6 +99,7 @@ static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
 	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	int ret;
 
 	if (state->polarity != PWM_POLARITY_INVERSED)
 		return -EINVAL;
@@ -106,7 +107,10 @@ static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->enabled) {
 		if (!pwm->state.enabled)
 			pm_runtime_get_sync(pwmchip_parent(chip));
-		return __dwc_pwm_configure_timer(dwc, pwm, state);
+		ret = __dwc_pwm_configure_timer(dwc, pwm, state);
+		if (ret && !pwm->state.enabled)
+			pm_runtime_put_sync(pwmchip_parent(chip));
+		return ret;
 	} else {
 		if (pwm->state.enabled) {
 			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
-- 
2.47.0
