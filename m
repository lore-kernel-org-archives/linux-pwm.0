Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E511D5CE0;
	Tue, 11 Aug 2026 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786489288; cv=none; b=GrV8qdov/FcJcHz1m7YzCJi7eNX9Cn3lV30Gyp+oFTwt2v5h6+Zpso4/mA88yav+qkjYZNn4pILYXqSUlvkbhRNCmM83vFqofFt5NUe8XSIabS1bPY0nTMMBSiJODSpWERGmO33v+dYTfQtqhUsGx8YmiMiFIfggUoreC2oxTmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786489288; c=relaxed/simple;
	bh=oKTkD7k/OmVMYC6QGDl1G08NwEJItuzdQVg3pLw97yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+axkW6LBApU4g3Lrp7AbHq0UpMeDlAqvjEyYj9N3ddlRwAMIHQ49R5PbnWl1C+lKnq6dBFQHRDWmWG94vTcV1TyT2jW0q+LgBrrI+kgsHiyFWtv98vrrD0gs6SbYKCeRzKlb+gzueZ8KeS9oz8uVrwnMtndLYmRwdHBxEprU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyrKvP+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyrKvP+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A191F000E9;
	Tue, 11 Aug 2026 23:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786489286;
	bh=FeV0k62/mpnJ6VJ9GI5IffO1V7QQd/8uA8y1iY3oRzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WyrKvP+vOMmEQL2E4667OuKIizJVPjqSFzrW8YdeeOsVvZfJyidHozqlRMS9OqwLi
	 xbOtHL/tZ+W7jSO7hxyBJ+c16Eu18eJcmK60jJIBU2eHonQ8tqLrVh0v733chQoubG
	 zA2OTcoKBl5aFPoV4TYu49S/jX5r0FHd2LVhyLh43y7U235PxkSl54XM9ITz6OR7Ck
	 rFSodhtsTTGqwDVD5MSZzRN0dVHTKkfXo1Eq9u7VEwufLCYpHO4s0oYMX9saj3ZgjQ
	 Sf/KoOGilmi/tGGzYFbhckffV5U04llUCqhKlw0KxjDMIDQWOUSFvZA9AvEJKzJbE/
	 61Zp2ryn3iUpw==
Date: Tue, 11 Aug 2026 19:01:23 -0400
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Francis Laniel <laniel_francis@privacyrequired.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Alexandre Courbot <acourbot@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org
Subject: Re: [PATCH v3] rust: pwm: replace `core::mem::zeroed` with
 `pin_init::zeroed`
Message-ID: <20260811-small-ubiquitous-caracal-ebb9cb@meerkat>
References: <20260603160910.159307-1-laniel_francis@privacyrequired.com>
 <anqsTVj5QGYGiEQ9@monoceros>
 <20260811-garrulous-serpent-of-agreement-cf9b19@meerkat>
 <anunw_qC23XMqye8@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anunw_qC23XMqye8@monoceros>

On Wed, Aug 12, 2026 at 12:56:05AM +0200, Uwe Kleine-König wrote:
> On Tue, Aug 11, 2026 at 04:54:47PM -0400, Konstantin Ryabitsev wrote:
> > On Tue, Aug 11, 2026 at 07:04:49AM +0200, Uwe Kleine-König wrote:
> > > I didn't research what went wrong there and the trailer made it into the
> > > patch anyhow and adding -S doesn't change the patch. I added the
> > > tools@k.o mailing list to Cc:, maybe someone there wants to debug that.
> > 
> > It was just Miguel responding with a suggestion how to better reorder
> > trailers. Since we can't tell this case from the case when someone actually
> > replies with a follow-up trailer, hence the error.
> 
> The strange thing from my POV is that before your mail Miguel didn't
> participate in that thread according to
> https://patch.msgid.link/20260603160910.159307-1-laniel_francis@privacyrequired.com .
> I'm confused.

It came from v2 of the series and was carried over because the patch-id hasn't
changed (meaning it's the same patch, so any code review trailers still apply).

https://lore.kernel.org/all/CANiq72n+tyDcabpwZOR1gHb4mycbpTQbzr0QNgi9c48cSnrZ8w@mail.gmail.com/

-K

