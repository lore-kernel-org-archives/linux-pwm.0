Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE454963D4
	for <linux-pwm@vger.kernel.org>; Thu,  3 Sep 2026 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436135; cv=none; b=rZozRz/1KmAmwZSEP9Lf2meS8yjnEfuI/WOg2jOklikvYB0gDS42yoPKj2z1Www7aizqPXh3nKE2cF+0G6UrvKhej+HFsrwOMo5ooJZji4Nnxes9+DI5hzUDjj5zxvyjJKtDilx98PbSLp8oleTp7btvy3hH7AfHd6XrtvJvrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436135; c=relaxed/simple;
	bh=Mj9zGH87ghz7jJUscsQ6i5eBH3sTOICS54MiuE3wo4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6HJdWfIXjthzST3am+AYNe1DFV1MGft0excNyfIAHDdMebSNrzA3N05vMzzQ44xIp1QwCByc5yoLXaGvKq37kozm7QS9P26m4DGYbgMyBUnh1I423BZwOFF0EglXjfvHRdYPf9KcSS4kZ31bAiStLVsc+RXsf6ALBrCzfX+j+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiZpPL5T; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiZpPL5T"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-485850cbac3so130883f8f.3
        for <linux-pwm@vger.kernel.org>; Thu, 03 Sep 2026 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788436126; x=1789040926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H68B7qRsXYaUK1b2//Fn/lfpS20viNTYXrL1yFyCiWE=;
        b=NiZpPL5TYsmqe1zXSmMpEeJ8QyP6sxFyskqrxU4oOxEJrx0vrgkRSZoimHriJKGz0B
         5r1O8B9kASp0OMR0HOlWUdIteKe1yBpXbKTBqqk1tGw7Fp6RrnMw5C4jBH3N7eIOCNt0
         NILEtEm7pxIkIiB9h1PVco638c0EAPK2CPaxmiQxsZG8xRl5AVZl0/NtRjJFAE+LIYlE
         BGUgQ/cNcDTxJj6hkdhu8ieMkbbWXVKD/i9gImMjogveocnt6nwap+ZCdTWZK+bdyY9U
         Luym0PUNnw1EQuWfvK9H1Fe2aTv3IgHAiZRo3k6D/KTJRSeKqKJ5ehU/BhoCJaQjBudV
         7zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436126; x=1789040926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H68B7qRsXYaUK1b2//Fn/lfpS20viNTYXrL1yFyCiWE=;
        b=ZiMJDMTfd2hZ/ftnOesvkNPwUVxeL4ZQq2UDMBwKsNtaWUmtV/vMNmEzZ/nDwfg9Ki
         w5lTlg5W1qK2EgYlFMq3EtXbX9O+m5pLzyfd8tC/qywa0ly+INtapTMw6LXDa6t+j5/F
         FSnALvSiXlV+SoL2xsEZ6O/A95zPVBXs/zo+Jsq5FdyuNtZQN9I8pVYafsONRjdmnBbU
         Xq8UmqcrC75yq5QmfbUhtu/kfcVdV5DTEnnNfQ9vPZvqBrCN4rXcfm3FO/rsT6csQ+Sd
         seRWzU8CEs1Nh1p5fPPUN051J69N3FDhpbek7w1R2KJyW3+JjXS2JGjw1JYlIsl2znhw
         7C1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwV55RxbZpvKsL3QeipQ7pglgooQPg4HbA+7Vy58FUDQCIuxumXzcLclOmu7RCg8IBscl5e1JaMOqc=@vger.kernel.org
X-Gm-Message-State: AFuF++ndVWS1mPhf5JLS9xR3gCPAxY0eUfcpNbXnI2Dix8IX1tsao8Tx
	eczBWrI8EJI4v36un5/hEXjofj1q2lJ6IWPh9s90zW0RR6HHn0rz9G+W
X-Gm-Gg: AYBFou1lUAzl1ynzIwziQ7Y1buRfIsvT8QwEvOG8QaeLzq30s5ZpPx/ExJTLONs6/cF
	nV1fYqe3n0CklunuNxpdcP7f4dQWHGC09zv0xsDROCJ0WyIeJEi9LkXtl4NbjnLX4ULu+fbvqNx
	yVZEfFxpbJBcNXAI728R3nl0ASmp0TEuPKIKhefNGFkY6sXCa5l36tIY1nZoAg6uszqwRtT73wJ
	siKMJhw7zWYwbfA+i++FhyLl1g2zfZ9fVy89BfjlK9kgvDS7A8Pi28+n/VTYXwafp9DN23GRzNQ
	LRHf4W39MaKR/U2xafa2ulgcXtICnunDSuc4V2Zfrru3brj8mDnTGNOEZYRLgZt1H7hOji5Hte/
	n8i7dPO83CpzmCh2AMegRLAOnZkxMs5tnIiftMzCi5WZLBxBuwAvy+gqZcQELjSakbo8B0bCw8R
	/P/XrW8EF+CwzzhUwZL+Y0c4tPR3EcS0rY1mjw8pAgVj0q+AHuEzDzDNGotrFhAVp1UCqk0QvBO
	391+vwZWYXc8q6q55O397Quu53iRjj1mvWrWCrebEYdYk75k7zgb+GajoU/Uyk=
X-Received: by 2002:a05:6000:2311:b0:484:414a:415d with SMTP id ffacd0b85a97d-484913bacc9mr20131848f8f.28.1788436126344;
        Thu, 03 Sep 2026 04:48:46 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed2edfsm12963594f8f.23.2026.09.03.04.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:48:45 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:48:44 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, 
	Frank Li <Frank.li@oss.nxp.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa <leonardo.costa@toradex.com>, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] of: property: fw_devlink: Follow GPIO nexus maps
Message-ID: <anoomrcvyeiir3yubqnnqflbk4wsyvgevvs3kiownkeeswzerj@ufju6cvhrzit>
References: <20260902-fw-devlink-nexus-ready-v1-0-68fe1996e78a@toradex.com>
 <20260902-fw-devlink-nexus-ready-v1-1-68fe1996e78a@toradex.com>
 <CAMRc=MfN73=K1nZrqUbhrMSijjpzhF_z_U9JU4_H163W0vRpqA@mail.gmail.com>
 <qg2nemg4mlxpancg7az2vsnjkfc4anxkieozoxh3mj3zgkyifd@b5b6yiz4uew3>
 <20260902185513.4867bc92@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260902185513.4867bc92@bootlin.com>

Hi Hervé,

On Wed, Sep 02, 2026 at 06:55:13PM +0200, Herve Codina wrote:
> Hi Ernest, Bartosz,
> 
> On Wed, 2 Sep 2026 15:22:36 +0200
> Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:
> 
> > On Wed, Sep 02, 2026 at 05:30:19AM -0700, Bartosz Golaszewski wrote:
> > > On Wed, 2 Sep 2026 13:41:39 +0200, Ernest Van Hoecke
> > > <ernestvanhoecke@gmail.com> said:  
> > > > From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > > >
> > > > GPIO consumers use of_parse_phandle_with_args_map() to resolve specifiers
> > > > through gpio-map properties. fw_devlink instead parses GPIO properties as  
> > > 
> > > Unlike PWM, there's no such thing as "gpio-map" properties.
> > >   
> > Hi Bartosz,
> > 
> > bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a
> > nexus node") added support for nexus nodes, and then c11e6f0f04db ("gpio:
> > Support gpio nexus dt bindings") added support for "gpio-map".
> > 
> > Herve later added support for pwm nexus dt bindings modeled on the GPIO
> > support in e71e46a6f19c ("pwm: Add support for pwm nexus dt bindings").
> > 
> > Please let me know if I misunderstood something.
> > 
> > > > direct phandle references, so it records the nexus node as the supplier
> > > > rather than the mapped GPIO provider.
> > > >  
> > > 
> > > Can you point me to an example? I'm not sure what a nexus node is in the
> > > context of GPIO.  
> > 
> > Stephen gave an example usage in his commit message implementing
> > of_parse_phandle_with_args_map():
> > 	soc {
> > 	        soc_gpio1: gpio-controller1 {
> > 	                #gpio-cells = <2>;
> > 	        };
> > 	
> > 	        soc_gpio2: gpio-controller2 {
> > 	                #gpio-cells = <2>;
> > 	        };
> > 	};
> > 
> > 	connector: connector {
> > 	        #gpio-cells = <2>;
> > 	        gpio-map = <0 0 &soc_gpio1 1 0>,
> > 	                   <1 0 &soc_gpio2 4 0>,
> > 	                   <2 0 &soc_gpio1 3 0>,
> > 	                   <3 0 &soc_gpio2 2 0>;
> > 	        gpio-map-mask = <0xf 0x0>;
> >         	gpio-map-pass-thru = <0x0 0x1>
> > 	};
> > 
> > 	expansion_device {
> >         	reset-gpios = <&connector 2 GPIO_ACTIVE_LOW>;
> > 	};
> 
> The binding is available in dtschema
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/gpio/gpio-nexus-node.yaml
> 
> And the gpio case is mentionned in the Devicetree Specification
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#specifier-mapping-example
> 
> > 
> > Admittedly, this hasn't seen much (any?) actual use in the device trees
> > yet.
> 
> Not yet in actual device trees but needed for handling hotpluging of extension
> boards.
> 
> For instance you can see at the following patch [1]
> https://lore.kernel.org/all/20260826094950.1088288-73-herve.codina@bootlin.com/
> 
> tests/fdtaddon_realistic_base.dts [2] describes a nexus node for gpios allowing
> to use "gpio 1 available at the connector" from the dtsa instead of "gpio 3
> provided by the GPIO A controller". This allow to decouple extension boards and
> base board. The common part is the connector. Extension boards dts uses
> resources available at the connector while base board dts "wires" resources to
> the connector. A translation in needed and Nexus nodes are part of this
> translation.
> 
> tests/fdtaddon_realistic_addon.dtsa [3] uses a gpio that is translated thanks
> to the nexus node:
> --- 8< ---
>   /* Use the connector gpio number 1 */
>   reset-gpios = <&connector 1 0>;
> --- 8< ---
> 
> 
> [1] https://lore.kernel.org/all/20260826094950.1088288-73-herve.codina@bootlin.com/
> [2] https://lore.kernel.org/all/20260826094950.1088288-73-herve.codina@bootlin.com/#Z31tests:fdtaddon_realistic_base.dts
> [3] https://lore.kernel.org/all/20260826094950.1088288-73-herve.codina@bootlin.com/#Z31tests:fdtaddon_realistic_addon.dtsa
> 

Thanks for explaining and linking your use cases here as well.

> 
> > 
> > We (Toradex) would like to use it to specify a LVDS connector on our
> > boards. This connector appears on different carrier boards that all mate
> > with the same display and have the same pinout. The only potential
> > difference is which PWMs and GPIOs are connected to the connector.
> > 
> > There, specifying the LVDS connector as a nexus node on the relevant
> > carrier board DTS/DTSI would allow us to reuse the same display overlay.
> > That example usage is given by Leonardo Costa here:
> > https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jbauradujrre@gc5nbdhhixaf/
> > Note how we have the connector on imx8mp-verdin-dev.dtsi but could also
> > add it to other boards, i.e: imx8mp-verdin-mallow.dtsi
> > 
> > Note that in that example we used the "tdx,verdin-lvds-connector"
> > compatible for the connector. Since this is a nexus node and just a
> > dumb connector without driver, not having a compatible would make sense.
> > In a final implementation we could specify a compatible + binding if
> > that specifies the ABI better. It is not entirely clear to me what is
> > preferred at the moment, but that is disconnected from this patch
> > series.
> 
> Hum, do you have a look at [4] ?
> You could be interrested by this work?
> 
> [4] https://lore.kernel.org/all/20260826094950.1088288-1-herve.codina@bootlin.com/
> 

Yes, we've started looking into it and are very interested in the work
on the connector concept.

Here, we can use nexus nodes to simplify an LVDS connector and share one
overlay for multiple carrier boards, but without a real generic
connector, we still have a lot of combinations we need to support, and
we cannot point to one specific connector on a board. The connector idea
would allow making our overlays more generic and reusing more. We will
be looking into it more. Thanks for your work on this!

> > 
> > >   
> > > > A nexus is a translation node, not the GPIO provider, and need not be
> > > > populated as a device. The resulting fwnode link can therefore remain
> > > > unresolved and indefinitely defer the consumer while
> > > > device_links_check_suppliers() waits for the nexus.
> > > >
> > > > Use the map-aware parser for all supported GPIO property spellings. This
> > > > makes fw_devlink resolve the same provider as the GPIO consumer API. Direct
> > > > GPIO references continue to work because the map-aware parser returns the
> > > > original provider when no gpio-map property is present.
> > > >
> > > > Add OF unittest coverage for mapped and direct GPIO suppliers, including
> > > > the deprecated singular and unprefixed property spellings.
> > > >  
> > > 
> > > Since this is a fix that we may want to backport, the unit tests should go in
> > > a separate, follow-up commit.
> > > 
> > > Bart  
> > 
> > Thanks for the feedback, if we want to go with the direction proposed
> > here I'll make sure to split it off in future series, I was unsure about
> > that.
> > 
> > Since usage of this nexus system seems limited, I'm also not sure if we
> > need to backport but it technically is a fix.
> 
> Not sure it is so limited :)
> 
> Also, I agree with both patches (PWM and GPIO).
> 
> fw_devlink should use the end device and not the first nexus node.
> 
> Best regards,
> Hervé

Glad to hear this is being used. From a quick experiment I noticed it
didn't really apply to kernels before v7.0, but we can see the state of
it once this moves out of RFC and I split the testing code off.

Kind regards,
Ernest

