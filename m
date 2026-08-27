Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC043F8B1
	for <linux-pwm@vger.kernel.org>; Thu, 27 Aug 2026 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828673; cv=none; b=kPlBXyYcBeNSXSK99hqExstnbGXZR0tBpDicm/ztSZqF9AnXCzeKxPo6kJX0tfZiqlDTwPP43MdgpR0JQObmdBei28N08MirYTAjvWm4cHxMdmV2uSVPZEr72UmLTZBxiri60NJuUnpeHhpF4Kqp7NOO6pzRN/kr4kHgUv1GaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828673; c=relaxed/simple;
	bh=j5s/NgS7kFJNIqCN8n4on73ScqJcMswb62IjXx5qwic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBuN6JVDWfqReLzzLfkRfjP4leFwH9EGIl9kKyZe4TdTTOUuXzb7RHfyJKbJcUQN95zaNY9DZk4f1LU69+KLWbtBJnJIsqYTpaqxD7SdSPGyrrtQteAjSFwsDScPWQCenIW0qkQgpE8Mn3DeLMe5dDdDQdFBitruBTowmu/0Dfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FNw8KbhC; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FNw8KbhC"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-783906bdb20so457002137.1
        for <linux-pwm@vger.kernel.org>; Thu, 27 Aug 2026 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787828664; x=1788433464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VYUvIldewK6PvTP1rIkGVol761Yt1VpaE72Hq+Vq9o0=;
        b=FNw8KbhCcFSwTglC597qKWzfOLEw4RYygJYRLUX9ZQgIn8NC/s+qUR79j/iDikaizo
         T8cymdv7v/kGgxQ5nJ864vpTUP/pLfrn0iA5JmOMZCGOZh/B+/8pTtv4cX2kiIdUWDIi
         bupNEoArLvuDRZ1uT8O3MNpp9Zuyb6JQftj84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787828664; x=1788433464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VYUvIldewK6PvTP1rIkGVol761Yt1VpaE72Hq+Vq9o0=;
        b=ZgAwqtLnwI33kuBj1xJY1oFyFOnTyWEutjkr1mmEzbQIn25UXo2MiP5OqMGi7UC6eM
         itG8NP5flYVRG9zlsv4fuWacWJ9/kuizaxWKp/5REbSSKhks+Q+3wDWQQo4s6Hz1li0H
         OP3mobsx1KCgtYpuWw/KPmM6zG2yhJWhsCffTVI+ClpQszLiorOvISvGWaj/W+VwhiDc
         79s43UbONFovEA5LK42jZCpA762oUTjGGk/WKBOKAfVn5BvaMjL4BkJxUgW7qnCIxc1y
         gMf+kMJ9yqetptxzw5ei1gOYxCokbDQUVuDxs9jBERTmJZkkOAxIXM0fEZCplKEvPQ5T
         elWw==
X-Forwarded-Encrypted: i=1; AHgh+RpcPCj+6G9zr/nI9Slaf1dMhKcQEUBip7n2LBBs9RNXztThsrPrfMhDIxTJ3VE++KtVodPYBz01HEM=@vger.kernel.org
X-Gm-Message-State: AFuF++nvHtqRSTR5g1XSUm5Wm8IXSBGTC5XMnjQfumcIsW1qW/OKeHow
	N+gnVRvwcvQylbz4d1cLjV41vgsSBx5zmG0OpBfwXpcFJjz7jNuAVRJZCEd5wg1tcWTOpPuyTD1
	pS7Y=
X-Gm-Gg: AR+sD10BbCrOt224KueH26p6uJx8ckw+wzk342jtpnZChqrcMM5JOiic0iImj39XEWo
	VGKezeUpqab40fBOWP7uxS4801zscvE5LdvoE9oCYqNIwcdfdwXA0oByHLgpaZlVTNXQTI7Ijq2
	/G8n0pxo7DKASjjvZQqHHae4hDAJSZiMM8SM9LPHeJXHE4DWga2S6hrSEolNejL9tpfwpoHAc6l
	es9MvNfEAVpLy4ZTXBidGLpQ5LBVOFB6tO0/eugXeJBPQn0wvYULP1KxWgTd0CI5XiRdCOCLyKS
	tiZ0TbJdrtz9jnlfNqnFTA+HA6VRpfOV/DxpMDJNVEXPkrNGqmI2ju+CQcfWq38Hw3NagO6Fr68
	4VadtLwfaINf0VhSvCXRYTrC9Tc5OjVnzvsLJ5VZ1uZ74A7lKCjA9r9mTKFB5799eMIcbowzftU
	VHni3X6NzCcXjiC5F7+bZqYgsqiXHFT49/yprFh8kG7t0ukMNSXv2T6V0ST+u4g9zdjNVAVUN1I
	CPgI3ODQXwM8ONxFzvF9ag=
X-Received: by 2002:a05:6102:3c9f:b0:779:dc0d:2b2d with SMTP id ada2fe7eead31-782c0bf8c46mr4363622137.8.1787828664064;
        Thu, 27 Aug 2026 04:04:24 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97ccc328fdasm2530990241.13.2026.08.27.04.04.22
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 04:04:22 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-96723c7151eso748778241.2
        for <linux-pwm@vger.kernel.org>; Thu, 27 Aug 2026 04:04:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqb7EaTB/gWNNJKEJrO6YIbYR83X7e9rGPCOKlE7m5r9frnq8GWCWuoP59I2leIeTzJYi5o1AD8JGU=@vger.kernel.org
X-Received: by 2002:a05:6102:3c9f:b0:779:dc0d:2b2d with SMTP id
 ada2fe7eead31-782c0bf8c46mr4363524137.8.1787828661149; Thu, 27 Aug 2026
 04:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827105738.8570-1-wenst@chromium.org>
In-Reply-To: <20260827105738.8570-1-wenst@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 27 Aug 2026 19:03:43 +0800
X-Gmail-Original-Message-ID: <CAC=S1niht1VnNpZrqVaAb87FLVM7ZtJLOiDgCroGVRg2w09WBw@mail.gmail.com>
X-Gm-Features: AcwNN1XxLwZk6xI-YXSc5CYXIrMIXfGVUxLqoDEmpH_birCWDntEpyOtQassyDE
Message-ID: <CAC=S1niht1VnNpZrqVaAb87FLVM7ZtJLOiDgCroGVRg2w09WBw@mail.gmail.com>
Subject: Re: [PATCH] pwm: mtk-disp: Fix period readback
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pwm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Jitao Shi <jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 6:57=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> The period value stored in the register is the number of clock cycles - 1=
.
>
> Account for the offset when calculating the period in nanoseconds. This
> fixes the discrepancy reported by the pwm core when CONFIG_PWM_DEBUG=3D1:
>
>     mediatek-disp-pwm 1100e000.pwm: .apply is not idempotent
>         (ena=3D1 pol=3D0 281500/499875) -> (ena=3D1 pol=3D0 281500/499750=
)
>
> Calculation discrepancy in the driver was found by AI run by a colleague
> while debugging another PWM related issue. Check against SoC datasheet
> and fix done by the author.
>
> Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
> Cc: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Fei Shao <fshao@chromium.org>
