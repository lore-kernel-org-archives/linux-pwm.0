Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE7469840
	for <linux-pwm@vger.kernel.org>; Fri, 11 Sep 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117801; cv=pass; b=vGJHl5XyD5VWVl5IbKRaCztouY7viBIZlB+89CUlZAPF2kPgQNV9SiRZIkaUfrHOd+rxwjrJM4OTbeqkMPIG3R4AswEj1NXD9ANxshAUzx8QlNuue/1G7VsRsaxowSWR7xNGGa6Ta2ldBAp8B83Pi0D7IN2wrHGHY1AuJ5LE/TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117801; c=relaxed/simple;
	bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpMCgxIEA4gdg/WMCX09KM8KvvO9Zmzt3KmJO1LtlaPDHL1p5xSqHW6xiZlHedmaSHNq7wRgLXX0EmA1H7DdunLetqCJiYI3HuKefwYwx2WolrebwqbwgEWJg7U3FDm0YDyY12Rrmxts/yDJr0f7BjWJyM6NGkOBzyuRpmF/nzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSlPe9Et; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSlPe9Et"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4843e9c5960so603280f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 11 Sep 2026 02:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117794; cv=none;
        d=google.com; s=arc-20260327;
        b=LB3AxVkS0lat7syEBb4VhheNs6MR8IvgP5XyT8BcRf0n7PioEzgz1JZkqvJF4O/nUx
         hEYvC8AQkx7jFbpIiRx3KI1RoT2nZDdysKpTb4So+QK8IlRwykNc94OgJzB+C9fn190a
         llWx+s1iZCQ1eKwK5Fg5jrCtVztiLulw3yQFSjY/bmW7GgVNnoEIZFkJ73fqdHfYUl2y
         aGPB3+6mhGAR983x+cth4e1BLAeRZLjH/GHztdCJ8yZ8O1j1scO8AXlfFrRvIpYC1rvp
         zqkwF9A3srmEYMJwQResVjNo99KKYpx2trQj4KXYHNwzjbeMfYEGmVw3EUXAlNDQD6oY
         LjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        fh=Hxhi6hKP4sKqFeSeXLicLuH8j1t7VINBGYV2FhaoI/U=;
        b=r4MfO1stlisxmQU1ZlsffPzfwl68VunRuc7tuEHnENIWGPiueN8k/uhb9G+FF/GSCj
         EoUNyrFA7rNWPuAIU9ilH4phiVJcMbI99VvLUFgrwt6bxzK+g832SBcIXoVLtCV3tDLr
         k3xSa6+0kMYYbbMOHLQM0kLmHCswo1Xm0eP5skexuHXLZjY133/itJ8ExfDMyeQ6sbc1
         j6QyDp0XSDce7qGcTJEIY+4usEBOStzglee3Kf0rWTumaLZmJCuQoWEHGA8xFU1KTzS/
         ueAXOuJdjnfyKAJD3RBu4I55uGkTcmLc0oDhrN/LFKS/jrf6B7iCcsGPeIYl1oUz297l
         u2/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789117793; x=1789722593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        b=MSlPe9Et/aYooxs+mmr25pr80uFZG23i1Ff+HYNwoUYblRVkid0l2inKFKvyYhCHpA
         74RMEIvUI+LYnoLKLKfOmV3XsO+idJkaF0kKg+yth0rRQtl5E2y2iqZ2+BzrV44esGe9
         Gfqu0/0FtTeTt/gj1nMdkeGllp4GG8/dPMW6SAduAajB2PJTTh0EyTtISUFtDK6olxs/
         iuCpPN7ycYnpIx1qtI10WS4KO12IM90KAskYtoHYQeaRXYEsRQKGp3BGi7i/JLvOBusZ
         K3RJXi816wGUGyT/m2NeekI8C+6tI9P5dFmWFfKhpigFYWlsVGwnGy/m0LuueQHmrlvX
         Kr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117793; x=1789722593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        b=d73jYn1wJTHSgINHkg3lxqN6gTsFVXEYjT12Bdr3zeU1cb7lcICT0Gsco5ytlZRpx8
         P7fOE2qi9ZomNGERgl2eSUJl729bdKJtSan05I4SRymd+zbf6BkyuA7mD3j4HNp/nd5C
         deJ1rEcwq7fDeCD3S5MrJ5DyJvLFMArLDhEdJUm09/BWS6o5wPRfFaNJi23yMS/3H/e0
         mfojXvdzNyn5vXQrq/hSADe4bpuIZC6jlM7p1RXnY7gr6B9ZnXnkh3EaD1NAoZznBH5B
         MCsT2x+M6WlcAjvfbIV0so6bMWQgIWlyK59MGzR3AXT+4c+la2bKnEnyngnp+T1EuT+a
         ErTQ==
X-Forwarded-Encrypted: i=1; AKwUvByZJ04tzUq8YA/AKpfyHEvfL9ZbEHWcO69V+ywP4OZ6hWZWD5nuxfsOSKWh92O19X4Jp6zTa2BmaN4=@vger.kernel.org
X-Gm-Message-State: AFuF++mvV5jocs6FIvOYl6X+FYrvyV8i461bNtyYK/Wko8clN/NdxYBX
	esfxt37OGAgFIsRgNBXdjh4V+P1b+T91rpBYb4JSDW1xsgXqXW74wqp8hhQHagiCn8gXAx1pMRH
	UpaCZQUAd0B7w72Ox3JT7BKQzQg3nekQbWfrkvIoh
X-Gm-Gg: AYBFou37ueeFNs4lM0WwL+bNKcrSILBJkmOYJQb2oP0O4hkYyF4IkgW+JuB3r/WKhuq
	vIcrJ/ckkp6ZOyeAPlF75omytVZqZ1yMbXfqjb9bcAm+VO6QrfndEfaJ8QP1Z/ow74phCBavkrK
	2Gt8oLlcJNlfPWsPCzJ7w2pg4O1/v62/Nwl1uwr0RZ5ojox7stiVAlxHwDJwNIEUVG1rlmY/iAd
	5TbCuiTOAO95AiQJa+/CV0Vtcn9y8NNJoeWlk6sSceivcl+OzPWrHzNPQiU9cDQ38u9gK9ZfTCt
	3oX5LyjEGvbfc3agBJJX0tvEz9zd3Lf8QUgrYHBkBWgvxgNvlyH2SH2YXFCOJhUYYuBIxjvmcAE
	FFVoC3+jcXzGY0HJpAcATuy+PfEse7PCRz5hs9mvRmSd/KPgUAnq6
X-Received: by 2002:a05:6000:118b:b0:485:8c16:5ef0 with SMTP id
 ffacd0b85a97d-486eb2fe6e9mr2544735f8f.42.1789117791504; Fri, 11 Sep 2026
 02:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-5-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-5-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:09:37 +0200
X-Gm-Features: AcwNN1U8uQc4Zj212gVRashrRro-WErwh8uVMQ_MWKQsPaL29993fZfZR2Hn4U8
Message-ID: <CAH5fLggBGvXayMT2QGo5JeQkYeJYc0L-348-kKLsBs_g45-fnQ@mail.gmail.com>
Subject: Re: [PATCH v21 5/9] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
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
	Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:02=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/351
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
