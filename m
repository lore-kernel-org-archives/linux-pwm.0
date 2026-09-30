Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D7443E54
	for <linux-pwm@vger.kernel.org>; Wed, 30 Sep 2026 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764058; cv=pass; b=ZB7FD9K/7Wzq/JpROPMs+3GmsF3lMJzPnYsPWO/vPWsLem2UTpsSV9/Sz2K+sybtlvZ9lF1Yska0ODSh/iN1r+iARolAzON/DRDkKAMsE7V58CsE9IyBBB/AXwQCJ16pglI6iV7Fbr8RZshC8Zak1C68nS6TTOOEAss12vQlzd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764058; c=relaxed/simple;
	bh=XvCWzYsO5117WS0fLcPugtOovWWwKR7emRvgKSPyYEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDVNriQvMgFjp25mqwDlMUc31rJzah7IOLIcJBQs3d+vKhKaaXo5hyU1eG0WahzQpYXgq/t8AcRdNcIIVZv/ZtHPxDbQILg8O1l1B0+GHJfwNYmwWeIo7LxHrP94c8A+fRucvDJuFnyX3D4rthaCDTph9K66NdOKLsS52npFp00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqDfQK32; arc=pass smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqDfQK32"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c99260bd9so57615eec.1
        for <linux-pwm@vger.kernel.org>; Wed, 30 Sep 2026 03:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790764051; cv=none;
        d=google.com; s=arc-20260327;
        b=d6QnODcmSTD/okXQs6G7SOpUacuzaSgvBKo/w3eFEM3yFIJ4jGBBp/xQmxBwhQxFJJ
         6Hwor8kTTjwU0iYs+gusgbzrSPGceWfTLRdxZIfw0z/eKVWRSJPnl7bpQ5UY1HiAAEgd
         ovSupH82QTD16U2Y9xFpaVV0Xyx6Lffsmoewy/epnw69msv0jCsS9TiIF8tD4Nfd/vHE
         j4TWoGqgnPtql7FsKY8wk+fRc9F4264OGODXenW/dphIHb5UghvKFr3LxQeBlBntqyyy
         VI+E6YeIsu8lqgIml1KmFqspt8NP+epSHitJ187sixBf2K7/SvTxVjt0wKHAepSir41J
         G5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VnWslcQfJFoVXI2eTJRtMgF2Yhhk9njWDc0SCnJiKsg=;
        fh=OOSr390ArOPMUa/mTyRlXDo2CzXw6rN7SkL9y41eOe4=;
        b=i/vaNOp1qS/C6DB8ACZoBIbvB9q/dql02crnIaIYYGJDzbSR1k0nFjZPpZyOBQM21L
         3xwdtIOzCwULJrlo/8Vq7z/RUUfWGClvNCNnyRA3WttdgCEhVQSYwa5nqzAqRgFNTCy2
         +8PF2+0gmQrUjU1L10GjPDkDzN2Zq8VUom4ut2VS5n7THgzWk1Eli08dXXOPri9AyydB
         t0kUV1WR61YoTS1WVRrDqkOA4sE9At53tRogF+wDxPKxjKjjBjNJ/0P8yoHj/D5rmTNv
         8uqDvKN1EJSuWqs7aRNdDzymQhAkFaTqYwUm+2ySc9CgvZQVpAATAHQBliZ47JNh6SrI
         1mGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790764051; x=1791368851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VnWslcQfJFoVXI2eTJRtMgF2Yhhk9njWDc0SCnJiKsg=;
        b=ZqDfQK32SxdlMSL7AML4DDYFSEn83S9XNnE8si1DlLMNsYKj+18tth+oXi+aVYu4iN
         qdK2VKpn3Bh9PxYNSNe+Ab7nCNB7/rL7TqLwUrTbqSx1Rs/1ena/9EPCqlsMXr23YEmU
         EMcdcamK7z8YhYRTaoB7hECpHWiMLiaMbI5zRnehidhHeL7CM6UKDWCwbMbgEmudN7a0
         MiB0chDVX/EV6XTAiLqLtrkcgTM2czOWF6KLhI23rgvtzuJKS4TIRnLG9AXTZPEMGz70
         vW4rZR5ErPqW0JEP7h1yBKERxrNJSbbGSk+YSpKgFVSfwVElqAKZfi5smSo/gSX6z8lH
         Lngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764051; x=1791368851;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VnWslcQfJFoVXI2eTJRtMgF2Yhhk9njWDc0SCnJiKsg=;
        b=JEgBE2ogpAkRPRvOMQKsPXiykMfeZc9Nx59cOlups3EvDZfODSZ9GWN1spq/MBhj4T
         7omYiuRCOcd/ScYbYDIPMKh7QqyWWbLHmg+yb7YZpUBGjaG1AsI+352Kh+ipGZB+LlOk
         yQ1+n0nIeLXNiLgW9L3Un0tsddG8bMKVroIZhVUiFhphijhC2PTgdujSSvJSyNYm/OAW
         GW6cEv3zfvjbfc3yaSn0v21racfTylk83le445eT22pN/zWfMvSEncLUYsafAD/Cw1Vp
         SsXYNtSzRRWedRG8FpfhihZ/nQprBzitakhS1CfyBQ075fZQS8s6yY1QViI6dJeon4tv
         TO/w==
X-Forwarded-Encrypted: i=1; AKwUvBwldpzy6N80IzcHt/R96TIFuE9DaOGUd6VhVryip0gWyTPX6vhjCGOTnk5dzrhsejZyDH+Jep2XMD8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHIfEI29fZTAw2EAyELN4PebTMFHVi6/lwORNqQJ31/gqX819x
	G8dKN81NyCTbDgNCGUY1niHJoLDvauel7HASCchoLcMYaZu6dPlkwU+KcS/dJW3yHH9FZbXlQdP
	VBt0b8V5SyJbf5aodp/WfdrXwpaR+SqA=
X-Gm-Gg: AYBFou3oBzmX4mewI6DUazK8eAkGlggDvtFYNg3dnYD2Qq62LMCWqbOo7iQMImAwNGa
	vSFJZ4h63nghuIEySoZOc3K4f8E1uJXhjVC8edb9L8LyEqw87Vuxvw2ZPtlsu9UuWtqLLf0tc3B
	EBDhVdQORuA44v4zMrmMJGsUoF9EgNDo1D38eAQb0rhc5sDWKYmtIkRUcUAkLd0Bz1SNjh5VR/q
	1FbjSsVufXAVJHGC7iLnvDIYlfdFmUytdytn26jVxIiK1X/cYNQu8GKTF7Xe1jShfb1dvE7TiGS
	I+d0stk/QyIuluIIYxsT0/sitHW3kYEWizMUR0FT4fOMsby3PS2OHJxJBth4d81Eltz9aFvAflc
	2YUYGajOXAVsGb6RxBpTgZ7EHfBnZEBcsg667jBkxZJ6jvmtbEYSIP4nTm14WF2qgy26LMejn3a
	EYV26wdQ25yl3mQ3OcI7dH19UGxUWf3yYcgj7RQ1x5Z4W3229WFmM=
X-Received: by 2002:a05:7300:e9c9:10b0:34b:7c9c:9a69 with SMTP id
 5a478bee46e88-34cd8795e5fmr2234714eec.0.1790764050978; Wed, 30 Sep 2026
 03:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930101257.1649945-1-tomo@flapping.org>
In-Reply-To: <20260930101257.1649945-1-tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Sep 2026 12:27:18 +0200
X-Gm-Features: AclHuK9Nh6JsI3E6OnYTw_dMYdR-qYkmEpYkodh3Keia0XE0NzXFf93RUybHrnk
Message-ID: <CANiq72nRjBM5gPGKbEka8M6uZ8aVmoCZx9z0aXSMCkm1Od42jg@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
To: FUJITA Tomonori <tomo@flapping.org>
Cc: fustini@kernel.org, guoren@kernel.org, ukleinek@kernel.org, 
	wefu@redhat.com, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, daniel.almeida@collabora.com, gary@garyguo.net, 
	linux-riscv@lists.infradead.org, lossin@kernel.org, m.wilczynski@samsung.com, 
	ojeda@kernel.org, tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 12:13=E2=80=AFPM FUJITA Tomonori <tomo@flapping.org=
> wrote:
>
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> Fix the following build error on 32-bit ARM with COMPILE_TEST:
>
>   ERROR: modpost: drivers/pwm/pwm_th1520.ko: symbol '__aeabi_uldivmod' un=
defined!
>
> The driver divides u64 values when it converts between nanoseconds and
> clock cycles. On 32-bit ARM, these divisions are compiled to calls to
> __aeabi_uldivmod, which the kernel does not provide.
>
> The TH1520 is a 64-bit RISC-V SoC, so the driver is only used on
> 64-bit kernels. There is no point in compile testing it on 32-bit.
> Limit COMPILE_TEST to 64BIT instead of changing the arithmetic to use
> the div64 helpers.
>
> Fixes: 3c180003dffb ("pwm: th1520: Fix missing Kconfig dependencies")
> Cc: stable@vger.kernel.org
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/=
topic/64bit.20division.20in.20.60pwm_th1520.2Ers.60/near/626825599
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Thanks Tomo!

If PWM wants me to pick it up for some reason, please let me know (I
don't plan at the moment to send a fixes PR, though).

Cheers,
Miguel
