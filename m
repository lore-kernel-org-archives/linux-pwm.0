From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: Remove CLK_IS_BASIC clk flag
Date: Fri, 26 Apr 2019 10:59:21 -0700
Message-ID: <155630156131.15276.5014003885761074101@swboyd.mtv.corp.google.com>
References: <20190425181447.60726-1-sboyd@kernel.org> <20190426152626.GD19559@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426152626.GD19559@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Quoting Thierry Reding (2019-04-26 08:26:26)
> On Thu, Apr 25, 2019 at 11:14:47AM -0700, Stephen Boyd wrote:
> [...]
> > base-commit: 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
> > prerequisite-patch-id: 6196ca807a15f9f4a67d5e6b8668b4f13442ac15
> > prerequisite-patch-id: 9532946d1be40c2b20af0591ac4636a4cf3b14dd
> > prerequisite-patch-id: 4e4a9591f5a4ac0d5a72e694da8fdae8c8dda352
> > prerequisite-patch-id: bcd75306e64ff866989a978127f6b16f7575d0d3
>=20
> Just curious: what are these? I mean, I have a pretty good guess what
> these are, but how do you use them?
>=20

I'm generating patches with git format-patch --base=3D<commit>. This chain
shows that the base commit is v5.1-rc1, i.e. 9e98c678c2d6 ("Linux
5.1-rc1") and then that there are four patches applied on top of that
commit that have these patch ids. If you were to pass the patches from
the mailing list through 'git patch-id' you would see these patch ids.
Or if I had pushed the patches out to linux-next I suppose I could have
generated with a --base argument pointing to the tip of a 'clk-ti'
branch.

For example, the first patch-id is essentially
https://lkml.kernel.org/r/1554365467-1325-2-git-send-email-t-kristo@ti.com
piped to 'git patch-id'. When I do that I get=20

6196ca807a15f9f4a67d5e6b8668b4f13442ac15 0000000000000000000000000000000000=
000000

and when I do that to the patch I've applied locally I get:

$ git show b88b5b7182b0 | git patch-id
6196ca807a15f9f4a67d5e6b8668b4f13442ac15 b88b5b7182b07ebdc1ab692b4fc6a10abf=
ff208d

I think there may be a typo in the docs or a bug in git though, because
when I pass that same patch to 'git patch-id --stable' it produces
another patch-id.

4cf9f89ca61d8002df1494b48fac618c66f6220d 0000000000000000000000000000000000=
000000

Caption: Something is wrong...

Either way, I'm not really using this so far but I figure it's useful if
robots want to pick up on this and have a patch-id database for changes
they've downloaded and tested from the list to figure out where to apply
patches. I'd like to use it to do something similar so I can properly
apply patches from the list onto the correct base commit and merge it
all up. That's a little ways off though because I've yet to start
working on a tool to do full on patch management via mailing lists.
Also, I haven't seen anyone else using this git feature yet. Maybe I
should add some hints in submitting-patches?
