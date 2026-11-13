Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584910;
	b=ycMjYAnm2pp6yZFfB07AL/y2NlUZaEpYsg6RWJPoNiWEaJovGfufjZoglGQ9gpjPXxBp
	 fNGYp5RIY7K7W+4iyZ6KoUIMjOiXjoTWLuqLklkpu0mMGxGanGdvHv+8aJLvYCu/p5Hg+
	 GyNgsZKj6XJTwrPqD8ZEGtNAAHylHmOJ88SiXM7xCtLSOXk9PxrvUFHIIiNseTRrP/QcU
	 lBpkdEYoix60eM78nw1V+kpIrNMi4fc6WuIEHR9ltzqIoCnN4s4MFR8kDcUrFTvNIpXSA
	 NWJAICJU+yTGJJK5fhQYycvd5j4DmjJNFb15biVJ3fdRGrTu/S058xSTpCkXYaDmLPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4JQ8+H0JmbBf+PQButIDd4R/MJa+hAkJuZe6gYLdONM=;
	b=Nj16idWmI4eynD07NQc1f1PETHEtRrHOTHYBsF3pYDjYtLKxA3MHgAnpZ4ZNnYmwtCTm
	 LTAFOBGmVFRObcLCrSTu5NjwQ+rB8k+dDksLjy3tGsw4UB8zdmKYzPyk5Gvg+ibvYtRoA
	 VpPRLXKE+EkMFvNesfFh2doaPAMh1Xf4hEXSY+BrXuxXuGJjnpycxnk++tzP9AEW9ZnkU
	 RsWXyMwqqFHqgK2m+5ErH6jIqP3GYICMejIcZAZDuWCAE7s3N0uNZeY2v9HGo4TahwE5W
	 dirxF6+0bMxM3v6uo2cZuTUyR0KMD14zjQF48wsjwlAHDc5tKy+4CS7SHf6F15cfjDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HxTPZOZ1;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F2606A335
	for <linux-pwm@vger.kernel.org>; Fri, 13 Nov 2026 15:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 160F2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HxTPZOZ1
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b244fb7fffso1145500c88.1
        for <linux-pwm@vger.kernel.org>; Fri, 13 Nov 2026 07:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794584909; x=1795189709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4JQ8+H0JmbBf+PQButIDd4R/MJa+hAkJuZe6gYLdONM=;
        b=HxTPZOZ1wdaQhJWrsAQGtyl1XKuZIm6V7/EM8G/h/K8YvOCiU6viMxkydeV3VpaeII
         kPaJzNl67Ki1bJd2U02hqCO3RZK8HuRkI8goikQ972Ac1umrpqeDa9PDXBtyHoFvaCDa
         EexRARJvUXFIuoGWo3LuQEf+pp/NxyZ3rXGjzn3RQueltc3D3m9hY0ZBFYXUMcKFj6di
         wpwWUcBpvOFEbNx8e09PlrYodBE6RSw5V6trVfQM92nJtAjF/1e56uCejMaUBYwQq0xx
         AtqKpIpzm3imbjqSuVxbsxB/uD0FuWGhj7j7KxumDigQ3yELfKsEtgy2n3US5HJep4ig
         wn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584909; x=1795189709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4JQ8+H0JmbBf+PQButIDd4R/MJa+hAkJuZe6gYLdONM=;
        b=Nw4Iaz5Q3g2guWrSdba6m0NK8d0t6hwVGTMWI6Z+84tCp6HCi3GMwxKhWn9CkVyhno
         p+dw4z7UXZT1cIjLTT5DM43YNKCd2Z1ivfuor6wdXYJq7OM7nCIYMWixGJrHQvrZyiJ9
         7yFs6k4o83vjH+/IZQtaW2jXtr/ejr6RPc/v34Ye2vzEPVsMACFhpcUtMMXxDhjyfJVB
         xaSigwNyvUI660Dv/swni93hVTljfhjSFt27c81Lmsm9C+MNa4AUIiLXmk3Yn+rUJgJC
         NmvQF0pQ7qhxU8e25OgvDMn78M2zF3jmOtsy05sU91qb4vzGnDu1wxTKnGe9rhPEvrWI
         EqcA==
X-Forwarded-Encrypted: i=1; AL+hErHqGkAJn5I6zXip2gpLayeVsnIPYeu/9fO2N48PwOPWdfO+Ff0nkBmHD3+nHJYxqaQRriiMYqsVuHs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xiesLfZAtTxNRjy2sxAFGgXrjuPeRa6cj04P1QDxxA6pYlgP8
	+SyWLLFr91mKPJ7WZ1n2Um2tjKFcjnRPzpo4I1ePydtd7T0UeE8EqTD9
X-Gm-Gg: AYBFou1z3Htu1wKOS+zzGWpDinwQ1en4ei9pGNYfEcAkljeJhgufL5qyNrsPpf0roMg
	sIKQAJMb1K+fdfgBOq4tdgXtQSJH3U3ucf6J6aDYs/ca+zOmfBlux2oorQaEtlbeZ60vKrR1YzF
	vuP8S1JbrIBlVIwQaDbR3rPRV1KdyT3utzY+j5Kri1A6AhNIAaGInu7gYRQl5eZOl30fZQWyPRd
	1mTq7r6j6XBf4xwvObNnk2SkcCbwIhd9BhubtahrsY9LWItsr7OXxan3mOrSPKkaiSKV6o4scPV
	XZre2/LDgCEO6JSe4YI4vXCp83ozQGRY1ln2O6cpK62AqiAFavB4mokGJCJed0Mj68+hI3LI+ra
	GN1st55zMBKUjPiIslmtcPefaJPM7xCba8ZP+j9lJmquJa/gpoCqLJBAmjgxfdTO9h9XLHN42Tp
	6TAK9R46FWxgsHq0Sfpqc/yC1jJ3mR5cEiZHh8CEbhCZFU2n90Jv2927AcpY5GYWVdl36CVwAqR
	gHXtPHwmWKK07D3jev+TcKjMgnv6MGhnovEJuNyU6rIOpYzyKFnzz7QJt8Bt0nekEnca7TJaHoL
	M/5qFaB+lqQgDX76LIpamncMyGHTY57cEhLKLTjmMqQT0oqUoDspn1wtjyhH9FLjJrr7EnU=
X-Received: by 2002:a05:7022:f905:b0:1a6:53cc:7454 with SMTP id a92af1059eb24-1b50311d32amr2553855c88.27.1794584909005;
        Fri, 13 Nov 2026 07:48:29 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b505b5bf76sm5641828c88.10.2026.11.13.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:48:28 -0800 (PST)
Date: Fri, 13 Nov 2026 07:48:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Eliav Farber <farbere@amazon.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Armin Wolf <W_Armin@gmx.de>, Sebastian Reichel <sre@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] Input: adp5585: use
 devm_blocking_notifier_chain_register()
Message-ID: <avcxRXFG57_mWX_P@google.com>
References: <20261113104218.32566-1-farbere@amazon.com>
 <20261113104218.32566-3-farbere@amazon.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113104218.32566-3-farbere@amazon.com>

On Fri, Nov 13, 2026 at 10:42:04AM +0000, Eliav Farber wrote:
> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> adp5585_keys_unreg_notifier() callback.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied, thank you.

-- 
Dmitry
