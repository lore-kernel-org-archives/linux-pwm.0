From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [alsa-devel] [PATCH v2 11/12] ASoC: tegra: register dependency
 parser for firmware nodes
Date: Mon, 13 Jul 2015 14:10:45 +0200
Message-ID: <CAAObsKDsEuDS46rW9CMuviDEDV-OVXe5q-kiWmw0D_n2D3Tf5A@mail.gmail.com>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
 <1435743667-11987-12-git-send-email-tomeu.vizoso@collabora.com>
 <20150701173802.GW11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150701173802.GW11162@sirena.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-pwm@vger.kernel.org

T24gMSBKdWx5IDIwMTUgYXQgMTk6MzgsIE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4g
d3JvdGU6Cj4gT24gV2VkLCBKdWwgMDEsIDIwMTUgYXQgMTE6NDE6MDZBTSArMDIwMCwgVG9tZXUg
Vml6b3NvIHdyb3RlOgo+Cj4+ICtzdGF0aWMgdm9pZCB0ZWdyYV9tYXg5ODA5MF9nZXRfZGVwZW5k
ZW5jaWVzKHN0cnVjdCBmd25vZGVfaGFuZGxlICpmd25vZGUsCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgKmRlcHMpCj4+ICt7Cj4+
ICsgICAgIGFkZF9kZXBlbmRlbmN5KGZ3bm9kZSwgIm52aWRpYSxpMnMtY29udHJvbGxlciIsIGRl
cHMpOwo+PiArICAgICBhZGRfZGVwZW5kZW5jeShmd25vZGUsICJudmlkaWEsYXVkaW8tY29kZWMi
LCBkZXBzKTsKPj4gK30KPgo+IFdoeSBpcyB0aGlzIGFsbCBiZWluZyBvcGVuIGNvZGVkIGluIGFu
IGluZGl2aWR1YWwgZHJpdmVyICh3ZSBhbHJlYWR5Cj4ga25vdyBhYm91dCBhbmQgbWFuYWdlIGFs
bCB0aGVzZSBkZXBlbmRlbmNpZXMgaW4gdGhlIGNvcmUuLi4pPyAgSWYgd2UncmUKPiBnb2luZyB0
byBkbyB0aGlzIEknZCBleHBlY3QgdGhlIGludGVyZmFjZSBmb3Igc3BlY2lmeWluZyBEVCBub2Rl
cyB0byB0aGUKPiBjb3JlIHRvIGJlIGNoYW5nZWQgdG8gc3VwcG9ydCB0aGlzLgoKQXJlIHlvdSB0
aGlua2luZyBvZiBjaGFuZ2luZyBkcml2ZXJzIHRvIGFjcXVpcmUgdGhlaXIgcmVzb3VyY2VzCnRo
cm91Z2ggQXJuZCdzIGRldm1fcHJvYmUgKG9ubHkgdGhhdCB0aGUgcmVzb3VyY2UgdGFibGUgd291
bGQgaGF2ZSB0bwpiZSBpbiBzdHJ1Y3QgZGV2aWNlX2RyaXZlcik/CgpodHRwczovL2xrbWwua2Vy
bmVsLm9yZy9nLzQ3NDIyNTguVEJpdEMzaFZ1T0B3dWVyZmVsCgpTb3VuZHMgbGlrZSBsb3RzIG9m
IGZ1biwgYnV0IHRoYXQgbWVhbnMgdGhhdCBhbnkgZ2l2ZW4gbWFjaGluZSB3aWxsCmdldCBvcmRl
cmVkIHByb2JlIG9ubHkgYWZ0ZXIgYWxsIHRoZSBkcml2ZXJzIGl0IHVzZXMgaGF2ZSBiZWVuIG1v
dmVkCnRvIHRoZSBuZXcgZGVjbGFyYXRpdmUgQVBJLgoKVEJILCB0aGF0IHNlZW1zIHJlYWxseSBm
YXIgYXdheS4KClJlZ2FyZHMsCgpUb21ldQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2RyaS1kZXZlbAo=
