Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FF1C77B7A
	for <linux-pwm@archiver.kernel.org>; Thu, 18 May 2023 21:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjERVPd (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 18 May 2023 17:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERVPc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 May 2023 17:15:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FC19B;
        Thu, 18 May 2023 14:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B70F0646F4;
        Thu, 18 May 2023 21:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C84C433D2;
        Thu, 18 May 2023 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684444531;
        bh=0GbRJmmb0szX5Z8KR+w8kYqd1Pn/50zYZ8c5pZKtZ6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGosN9iS6qcYJgmfGiTFfLMjRkSUz3iR3zEFShczRoYHaoEbnAhJpVYT2epeomjZB
         /lNAmQsSOMNzrQb+Ostyy6U0jifRJJHKtJZizGLP2x153NW/pjARAaQ1gSPJB3mZjr
         4nvtDobnAOm3ki3FUtbPtI/zH1l7f9tCqZRWHEvuKEPULRM7AQO4eatNkNB7BwXsvj
         XEksc4kNZof/MzHIgjFmlZPCj0+NqcgVkEcUrAEDjZQV/LVqGnzNMp1T0hourHzZtz
         j6J0/sOVv2VqH5jbNVL1SZnPSz1tGTAbJEFO3vQqx1VsAK7ATnMw/Tf8hQNAufux/O
         6ttcsVq3EJn7A==
Date:   Thu, 18 May 2023 22:15:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v18 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230518-rebalance-crushed-e9887935e886@spud>
References: <20230518-reactive-nursing-23b7fe093048@wendy>
 <20230518-dandy-bless-fbd1e2c23dd0@wendy>
 <20230518151425.fy45t6brs7a7rmdm@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0BfJ5Y3OwcESuf5w"
Content-Disposition: inline
In-Reply-To: <20230518151425.fy45t6brs7a7rmdm@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--0BfJ5Y3OwcESuf5w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 05:14:25PM +0200, Uwe Kleine-K=F6nig wrote:

> Thanks for perseverance,

It has felt a bit like it was never going to end.. Hopefully I don't get
some customer asking why they're limited in period options.

Thanks for your perseverance in reviewing it, at least you got someone
nodding along to your FOSDEM talk out of it!

Conor.

--0BfJ5Y3OwcESuf5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGaVbwAKCRB4tDGHoIJi
0k3BAQChZNCcWspoAd2XAqkDwy2CUQcxetYLpBikSE0flsdVJgD/Wxqb4T9tXEw+
4pYome42taVpjqOtyrThWWAAT9b1IAo=
=p+on
-----END PGP SIGNATURE-----

--0BfJ5Y3OwcESuf5w--
