Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713231813A
	for <linux-pwm@vger.kernel.org>; Wed,  5 Aug 2026 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950464; cv=pass; b=Tf4GKeRG7Ct2UdjrM4sdiy95oKU2GxQUUa0CIgez7pmogOFBnxfjJy2cJ477h30kVH2/8Z4hPHPORF7jYWRMf7ExgKNQAEFbZc6BHb62bGt8fGPZ/bcFDGdDYEX8TZF7uQ4ExiSKR+rZ7d4LhxH3eG29RXewXV+ZO57uxPkGRfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950464; c=relaxed/simple;
	bh=f+1hgjoLe+9OAau5GDXmSyjb/F1lcu3rz3NObPtffwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T32vmRCrDLJV6WaRHZwdc5gEuUlsp1GWuwo0WMWgdP/FT+sZXd/2e1Zk82aMxv8W7fpXeMzoyoKjYAEwa79kYANlthfkTFmvG3lDptpF8QJGw+ae64Tt/dyPaBbahi4g8Xq4VnlG+4DaUDAp2uhYuOGr9sGlemjsvxPTyjefPso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT1xHc2x; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT1xHc2x"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8612812170so123989a12.2
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2026 10:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785950460; cv=none;
        d=google.com; s=arc-20260327;
        b=WpmyQ1w+KUxjhPkn1ez+u/Gohc4kcvI1WZyR9iHTmo4YkZjbAKfOYmSnMxjDI5VIC7
         OCprK9uFGQ+VBpP6oDaSEVp9o1i9OFB8j+/eMkQQQVXRXEdUitlU4bTqAJbDcba1ceex
         29+PM/XVneBV8VeTInYOAqblQ69Lc2a7Apf4ySsOFfV/qEE24cSxtuOpMwAf6Cvf6UKF
         12xURU6vFpACfDaJ8t9itm0XcBNwNPpmY2Ik2SPUs5pshsJoeaivlZYpNQs6XzVtfGVh
         KsNn3boY4yBtcXwcidImaIUejV90kmoPZuro2pOnw0Yf9D99GHJrnP6pRJENRToj6D8d
         4TRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        fh=BnBJmNx18ozRTxj0RMpyEPaMaQiPZ09vPL9Qdx5SXo4=;
        b=od9iAZqGEAlPN635bFQgkrTzdMu+RicgaxZB8Q6HZmh2q/UKb8L+tB3cOUF09zT55S
         fcSByWS17OGFVz2toxoVJvLbGX7NBOmOeoe7FD1xEdxPfHl97dcs+Xh5rrLSDODzv5XQ
         bpQOqubnLkvWQVD1CpSVkD5Hthy6ivufUnERLMoihFVLs79BMXEtOGxik1r3eMEJjKZt
         ufp/8FLBAd/evQAm3h3DtbkYAB9OM3wXHSshVLpytHGXnk4Zjwg1q85h4Y9x2QCabnx0
         V+6zPG/xwYj/kDcLMzW0IvdYZp7MiFB++cdFiV+6uDivpqRm1/xiECaXWNAmgsD4I0iX
         o8kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785950460; x=1786555260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        b=ZT1xHc2xyP9XYk8PUPnDAntsicElF5elLjXJHYxK/dTIRxhOXP4BYmKyaAm7D4myJe
         FXySCyN7nRIDJjvQu9UXCW9eDvMXBTKWNXVzmoLwbtoeTkM+2avemvUwcCdFVmdxcM5y
         HMcojfHT74MtjHUYX3FGuPiSQu6CG9RcMZN10Jij5DCneHFtm2g+5oKnouFZiqpXEehp
         s6g/qW8DnpBdkqN4RMvOha0mJmzKRXFYxdpGFxxrgKrHq8SOqH3+XjNo42K8aYfHQQpY
         ieaRXp6TarxQO7iZdwat5LWdNaE6ED/8Ui2j8nc1nYOEyzIfdGs6la8xuL4tQi7opQXq
         gWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785950460; x=1786555260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        b=Jm7fPOJ6hAa6sDa9wJRU+MNGD0KblvfyCJbi7uyCTTq9TgEimMWYgfajpgit/QiG0+
         QQNcqkcRubzz88J38mNAX6VtonVQTkrK/gCyJ2HieKj32wWiSd6CbiaXujDGgkPoGsUN
         i58JrfIh99F5cjzgmjqvJkKOJjW2x4dZVcN4P2977rKNeeWdI+fRXoaEtVhn052XAh5P
         oy0nHq1upu4bgbAj2JGydTl2EV7J4TCL5Ysd+A6THVvciXtBzm5cXLZqpqrb34SluS8O
         bCctsjZqbcePDHHP7dul3x63cFFX/R3Xp5m07fGhCFMDyxx10cMZmCjXOMSDUlUTQ3K+
         lhZw==
X-Forwarded-Encrypted: i=1; AHgh+Rqn3PC8/Emhn+RRNfKATcssrlsewc0jb5KbOwnlO0xVPpnminy5XX0tqdOgdNtiPzTZI09BfCC/gJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGsvRGdAHgMfo7Max/c8+78hU8VrRkuxZLG/gK/b0ZufNUM2Y
	PgO6X+4nmtznCnAcagTjTWdx9lKKj7UYaeY9mOD+zmYx5PI2pUWUiG1X+DPI0TLKcExR/qdkSOD
	oTDSxbyCoSgUaCI/vnQSQEw6xwJCPP4g=
X-Gm-Gg: AR+sD11H19Bl9zhBAu1/4UBjnG3JQXXBFhNtinTgOXEFrCMOhYWknVQGqrbVDlLELPw
	DIn1BcIhRWXXOhtTElNmrf3tfZ8U2GetL/LqjkyQ3Ky3+0Ki3dMEaA2SGgldxZ25i/FAidvZmpZ
	CGp5TDRcDxqlL/Tk0K9Yy3dpz0NkiKWGvXqubAnV5GcRHls7dNtO5JZycfzZ/m7JXkixEcrpGhg
	WrLOeInXH5WvFNZViSBoOcNCGRt0WRc5ymrpjX1qRBBSoUQ8WU8UsI4/ip3ruD1ORWdUnXE/Z7E
	2dR3/LT7ScdYfvhLEsncrZon4Bw2CcDHzReW7G5pLaqYbzzCU+xnJsLD7EjolYp+7GLKzgmzlVs
	aUH7JAy/fvA4dsIkK9E++/HmBUVhq2zEVpYgxWCB9jjyc9GH1Z85Fq58K9nlk
X-Received: by 2002:a17:902:ec8a:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2d0ca1658f2mr73522915ad.0.1785950460122; Wed, 05 Aug 2026
 10:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0CoR7Z5B4-PH8GYYbWlZysVJpMnNLTFzTO0tBlOpJQNFiQ2CPrhdjyD4-4jQs4n0J_1QqovCd_EaYpclyigEKw==@protonmail.internalid>
 <20260628095132.47753-1-trev@trevrosa.dev> <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Aug 2026 19:20:45 +0200
X-Gm-Features: AUfX_mwN2wRwvmcNPuq0EpEyS5qgayFtXbsdflDPhbgmFxUJf-YMOIqJTLTJEvs
Message-ID: <CANiq72=wo4LOfa3hrJhTFr8UzkchW4QQtUespCTq7qRJvrr6CA@mail.gmail.com>
Subject: Re: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Trevor Chan <trev@trevrosa.dev>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, igor.korotin@linux.dev, vireshk@kernel.org, nm@ti.com, 
	sboyd@kernel.org, m.wilczynski@samsung.com, boqun@kernel.org, 
	gary@garyguo.net, axboe@kernel.dk, daniel.almeida@collabora.com, 
	shankari.ak0208@gmail.com, lyude@redhat.com, j@jananu.net, lossin@kernel.org, 
	acourbot@nvidia.com, markus.probst@posteo.de, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, david.m.ertman@intel.com, iweiny@kernel.org, 
	leon@kernel.org, bjorn3_gh@protonmail.com, tmgross@umich.edu, 
	tamird@kernel.org, work@onurozkan.dev, sergeh@kernel.org, 
	matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, jack@suse.cz, 
	ljs@kernel.org, liam@infradead.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ptikhomirov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:26=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

In case it helps, there was a v7 of this one:

  https://lore.kernel.org/rust-for-linux/20260628100731.64885-1-trev@trevro=
sa.dev/#r

Cheers,
Miguel
