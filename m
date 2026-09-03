Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416504AF9F0
	for <linux-pwm@vger.kernel.org>; Thu,  3 Sep 2026 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442147; cv=pass; b=sqm4phNFTsLO9yPmqhu3vXmNrjg/MTa3BXVLnDBXtCEtxBunDWFhFyyJ4SUARaI3P2u3XQFjL7yWUTZyhotG7ODPhvMEA6vvvQxd3jHFF+9ZLyYmyWIK1fFD2dpTB9tXUwzX5tRXW0/4lR+v1C696aXB0zOlzJVUn1iA8JaaJ9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442147; c=relaxed/simple;
	bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C19C8ZvOEyGnHfI0TWd03+0TrHs5npCGFfZ5dfu+qNhi6c7yYJfVMH94Twin39lef4vx79pCsXZred0qVFasa/LlwAGb1wJXWHf6whnax96Qas/h0p9hqoPLVrGnUBezm8CBcmWP/vp4lZ3pm3NjM+SvaMlq+Z2XGos47dWBGgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QibOJQnk; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QibOJQnk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d900ac39ffso2954935ad.1
        for <linux-pwm@vger.kernel.org>; Thu, 03 Sep 2026 06:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788442137; cv=none;
        d=google.com; s=arc-20260327;
        b=mKfFNzVV4v1Q3fmDCo/veDGb3ekbiyeAgCd5BMZ1YMp6Goc6kJBfAntCYjRxVHpdYz
         vydSDoI1DbYm6Mp8ebsaBg00T9LK4K2xi7jXlEFC9aHr0CeWptbdhuTtpIc0qUs0EE4D
         PVByjlHQivhx5OWHI3Qi+LKtXLHZPoXiavE1Qb41PM5zAz6qV7xlpY7i3VmME5qt/VkT
         emmSFXnQyT/pt9v5Wd7XC0IVyBeIAl2+RYDEH4aH+ryMviPeNUDJZhchb8sCK2l9wLkA
         Nlt4SyOyfyiTlZ8yz4mz+z+7xLPxz8x8FX8RTalLiO+OFgHzvm1DX9AgCoRKR/iJrjVy
         o22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        fh=DKQZXNtV0QmsQnmJDBrM/eXmu/U1GJDGX8dLsgVjZ2M=;
        b=IvrFt7oGtNjrH/jGLKipU9NFr2GEok9WO0Y/RYrjaMR0ueFyy2WwgOQ4g0X8x5gCsX
         4vPs8HD9CLHJftrK5dLaKmIZvxk91NT+drAyfA8uolXf0ACtcn/t6kyPWqVn/xNqkO1+
         FkIW5oUyfwxMY7Oooxeh1O4ofYp6zs2mEMMvt1GZu9RFU0YuDy+fr0nQAsPNITFu9ryC
         A+UYOcIp9JXR8RrLJw+eybk3t38ahWP1KcRBhnH6qu01OVpzcomlQfpLdWOLvPzEv0T+
         /Uy1j7sc2ITPko03FSLpdTnkLEqzbRzXpu+SswN1TfMGaPfYjwJ9qCP/pY+2ZV6Kqgvx
         Ph2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788442137; x=1789046937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        b=QibOJQnk1IcJqAPts7niHKXB4MYd7rKKk/wudeEGKQp0iGQwDGwevv3JskZ75xdch6
         jfqm4L1dCpknWVRfoup0pgPVeoVkxrEgPBofP5UlvVojRvaPkpNXhQFo3YOpI5eUKzJ3
         oVIpCzNOrezqt2zVbyS0+jWle3e6IbhPsEo3ji4QqZhQGS8vqm75osJq5KNHbniSe7Cs
         7IMjXLKRAKNvoWjZP6f0QpU7q5nxhdS5rzzAAq7Cy/eRo92sBJSuU2C/89sY38/jJfVI
         jvANMBPDBxnLupAoA5f1OGYcmYjS1lAQ1aXvNLhVjMv0fKwt2U1nwuAN5oFlZ7SxOXAL
         4HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442137; x=1789046937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        b=fAI6pDV9bWEfzs8C38/ZG9tn4D/cyCi66xcZx4UemKxJStSOV0PekG8ckcsQSi017H
         3vPdWKkLQyAno9+iBbwXYczFrDgEcn9+qBZPHFvPRkQU/ZtjAe14fBvcocZ+LWdUTFna
         4gUZPhyNqWMAd4abl5mvsxLJtKlgBAC3o5j/tNCfRKkEyyvvRE72zy9C97R/bkgYq/xo
         syiNpe6DO9k+VOh0f8zRylD0gh6bVgiYRi1kvhM4RX7GK2blxbZnzgr382rOKfFv3WLR
         L9ZOEU/9C0RjUtFx2HfPZWD9/pYbw+nurkW8PNcoTfUbhmp6Jn1zp3ktk3TpZriTEw4H
         3Rlw==
X-Forwarded-Encrypted: i=1; AKwUvByTAp8kdq3HX31wPRxrCcJWvoC7C1YoBqCGW5uHqCon9ulTQmTO0Msk2NRIeV/+WNCowuEDyqGvpNs=@vger.kernel.org
X-Gm-Message-State: AFuF++k+hNRTkKcEo55oUu4lNcWuJS0tqNxLaXCh27vzwneYRyowQbzn
	SA5Z2M47WLOMWFlUaNCg0NhWry9FRLCrIPK4tOvfuEqa2ke8X+m1TNLCFYDKjK1xfSaznSrDDI2
	IdF1b4wxY/2BoZpMSm9XeMC7LW2q9GXE=
X-Gm-Gg: AYBFou17fJf0eRh6po9fms4f3u7g72UPoxTU/xwogIi/wV16Jj/IoUBF0Cllc1JRwXZ
	bbXIg4tATtr+AL+13wb4B/qPk3tLD7O2f1o/3xOrNn/4MuqMbF2EWCQ/yBpYNCK8OpiKT7oupl1
	hih3VD2NlbIxuFEF8fTNg6/RlUxo63F7Lv57Su4uz35Ws4ExozhJfgQicdf6elfVmQduq0qls+2
	UoIn4ucFPSexPpyGHNE9fBCX4XUyYZWDY5iqbKaEAj9pVjsIWtbCpQqaHuekKmM87louLggfacS
	8tdd9k7GnTWlmhKYUchx1Ke7rwVXOmho8d70Ho8Yuhtp63lIX7lyEifLrw2+pJ2d7Dm7DIxCqId
	d6B7gy9rmeJnANMuWJJSnG9Gob4jfkE2EYcBV/U++Ltnu1yi6k7j/N9fwzXGF
X-Received: by 2002:a17:90b:1d0d:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-39aee0e6ed8mr12609481a91.3.1788442136905; Thu, 03 Sep 2026
 06:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-6-490735672187@kernel.org> <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
 <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 15:28:43 +0200
X-Gm-Features: AcwNN1XsmuEPyO39jqyvRGfAMw_DGGPMkiDRHtfg1ZEoNlBhpVDCHnmjvBP_pa8
Message-ID: <CANiq72muo8SotJHJQhEe=2kiprbrQTvrEMqd1Uw_7yNSfA3Gpw@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Do you want a link to this issue with a regular `Link:` tag?

Yeah, thanks!

Cheers,
Miguel
