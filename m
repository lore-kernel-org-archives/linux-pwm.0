From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle
 to u64
Date: Thu, 23 Apr 2020 12:48:57 +0100
Message-ID: <20200423114857.GG3612@dell>
References: <cover.1587523702.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <cover.1587523702.git.gurus@codeaurora.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-fbdev@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>, Kamil Debski <kamil@wypas.org>, dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, Chen-Yu Tsai <wens@csie.org>, NXP Linux Team <linux-imx@nxp.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org, linux-pwm
List-Id: linux-pwm@vger.kernel.org

T24gVHVlLCAyMSBBcHIgMjAyMCwgR3VydSBEYXMgU3JpbmFnZXNoIHdyb3RlOgoKPiBbUkVRVUVT
VF0KPiAKPiBXb3VsZCBpdCBiZSBwb3NzaWJsZSBmb3IgdGhlIHBhdGNoZXMgdGhhdCBoYXZlIGFs
cmVhZHkgcmVjZWl2ZWQgQWNrZWQtYnkncyBpbgo+IHRoaXMgc2VyaWVzIHRvIGJlIGFjY2VwdGVk
IGFuZCBhcHBsaWVkIHRvIHRoZSB0cmVlPyBJIGxvc3QgYW4gQWNrZWQtYnkgKGluCj4gaW50ZWwt
cGFuZWwuYykgYmVjYXVzZSBpdCBoYWQgYSBtZXJnZSBjb25mbGljdCB3aXRoIGEgbmV3IGNoYW5n
ZSB0aGF0IGNhbWUgaW4KPiBhZnRlciBJIHJlYmFzZWQgdG8gdGlwLiBJIHdhc24ndCBzdXJlIGVh
cmxpZXIgYWJvdXQgYWNjZXB0aW5nIHNpbmdsZSBwYXRjaGVzIGFzCj4gb3Bwb3NlZCB0byB0aGUg
ZW50aXJlIHNlcmllcyBlbiBtYXNzZSwgYnV0IHRoaXMgZXZlbnQgaGFzIGdvdCBtZSB0aGlua2lu
Zy4KPiAKPiBbQ09WRVIgTEVUVEVSXQo+IAo+IEJlY2F1c2UgcGVyaW9kIGFuZCBkdXR5IGN5Y2xl
IGFyZSBkZWZpbmVkIGluIHRoZSBQV00gZnJhbWV3b3JrIHN0cnVjdHMgYXMgaW50cwo+IHdpdGgg
dW5pdHMgb2YgbmFub3NlY29uZHMsIHRoZSBtYXhpbXVtIHRpbWUgZHVyYXRpb24gdGhhdCBjYW4g
YmUgc2V0IGlzIGxpbWl0ZWQKPiB0byB+Mi4xNDcgc2Vjb25kcy4gQ29uc2VxdWVudGx5LCBhcHBs
aWNhdGlvbnMgZGVzaXJpbmcgdG8gc2V0IGdyZWF0ZXIgdGltZQo+IHBlcmlvZHMgdmlhIHRoZSBQ
V00gZnJhbWV3b3JrIGFyZSBub3QgYmUgYWJsZSB0byBkbyBzbyAtIGxpa2UsIGZvciBpbnN0YW5j
ZSwKPiBjYXVzaW5nIGFuIExFRCB0byBibGluayBhdCBhbiBpbnRlcnZhbCBvZiA1IHNlY29uZHMu
Cj4gCj4gUmVkZWZpbmluZyB0aGUgcGVyaW9kIGFuZCBkdXR5IGN5Y2xlIHN0cnVjdCBtZW1iZXJz
IGluIHRoZSBjb3JlIFBXTSBmcmFtZXdvcmsKPiBzdHJ1Y3RzIGFzIHU2NCB2YWx1ZXMgd2lsbCBl
bmFibGUgbGFyZ2VyIHRpbWUgZHVyYXRpb25zIHRvIGJlIHNldCBhbmQgc29sdmUKPiB0aGlzIHBy
b2JsZW0uIFN1Y2ggYSBjaGFuZ2UgdG8gdGhlIGZyYW1ld29yayBtYW5kYXRlcyB0aGF0IGRyaXZl
cnMgdXNpbmcgdGhlc2UKPiBzdHJ1Y3QgbWVtYmVycyAoYW5kIGNvcnJlc3BvbmRpbmcgaGVscGVy
IGZ1bmN0aW9ucykgYWxzbyBiZSBtb2RpZmllZCBjb3JyZWN0bHkKPiBpbiBvcmRlciB0byBwcmV2
ZW50IGNvbXBpbGF0aW9uIGVycm9ycy4KPiAKPiBUaGlzIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2Vz
IHRoZSBjaGFuZ2VzIHRvIGFsbCB0aGUgZHJpdmVycyBmaXJzdCwgZm9sbG93ZWQgYnkKPiB0aGUg
ZnJhbWV3b3JrIGNoYW5nZSBhdCB0aGUgdmVyeSBlbmQgc28gdGhhdCB3aGVuIHRoZSBsYXR0ZXIg
aXMgYXBwbGllZCwgYWxsCj4gdGhlIGRyaXZlcnMgYXJlIGluIGdvb2Qgc2hhcGUgYW5kIHRoZXJl
IGFyZSBubyBjb21waWxhdGlvbiBlcnJvcnMuCgpXaGF0J3MgdGhlIG1lcmdlIHBsYW4gZm9yIHRo
aXMgc2V0PwoKRllJLCBpdCdzIGJldHRlciB0byBzZW5kIGFsbCBwYXRjaGVzIHRvIGFsbCBwYXJ0
aWVzLiAgVGhhdCB3YXkKbWFpbnRhaW5lcnMgYW5kIGludGVyZXN0ZWQgcGVyc29ucyBjYW4gZm9s
bG93IHRoZSBkaXNjdXNzaW9uIGFuZApwcm9ncmVzcywgb3IgbGFjayB0aGVyZSBvZi4KCi0tIApM
ZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNlcnZpY2VzIFRlY2huaWNhbCBMZWFkCkxpbmFy
by5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJv
OiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2ludGVsLWdmeAo=
